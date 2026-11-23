package com.cybertutor.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.cybertutor.app.ui.theme.CyberTutorTheme
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            CyberTutorTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    PantallaPrincipal(Modifier.padding(innerPadding))
                }
            }
        }
    }
}

/** Llama al webhook de n8n y devuelve el texto del agente (o un mensaje de error). */
suspend fun consultarAgente(codigo: String, mensaje: String): String = withContext(Dispatchers.IO) {
    try {
        val conn = URL(BuildConfig.WEBHOOK_URL).openConnection() as HttpURLConnection
        conn.requestMethod = "POST"
        conn.connectTimeout = 15000
        conn.readTimeout = 90000          // el agente puede tardar varios segundos
        conn.doOutput = true
        conn.setRequestProperty("Content-Type", "application/json; charset=utf-8")
        conn.setRequestProperty("X-API-Key", BuildConfig.API_KEY)
        val body = JSONObject().put("codigo", codigo).put("mensaje", mensaje).toString()
        conn.outputStream.use { it.write(body.toByteArray(Charsets.UTF_8)) }

        val status = conn.responseCode
        val stream = if (status in 200..299) conn.inputStream else conn.errorStream
        val texto = stream?.bufferedReader(Charsets.UTF_8)?.use { it.readText() } ?: ""
        if (status in 200..299) JSONObject(texto).getString("respuesta")
        else "El servidor respondió con error $status."
    } catch (e: Exception) {
        "No se pudo conectar con el servidor: ${e.message}"
    }
}

/** El agente responde en Markdown; aquí lo dejamos legible en texto plano. */
fun limpiar(t: String): String =
    t.replace("**", "").replace("###", "").replace("---", "")
        .replace(Regex("(?m)^\\s*\\* "), "• ").trim()

@Composable
fun PantallaPrincipal(modifier: Modifier = Modifier) {
    var codigo by remember { mutableStateOf("E0001") }
    var pregunta by remember { mutableStateOf("") }
    var respuesta by remember { mutableStateOf("Elige una consulta para empezar.") }
    var cargando by remember { mutableStateOf(false) }
    val scope = rememberCoroutineScope()

    fun enviar(mensaje: String) {
        if (cargando || codigo.isBlank()) return
        cargando = true
        respuesta = ""
        scope.launch {
            respuesta = limpiar(consultarAgente(codigo.trim(), mensaje))
            cargando = false
        }
    }

    Column(
        modifier = modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(10.dp)
    ) {
        Text("CyberTutor", style = MaterialTheme.typography.headlineMedium)
        Text("Asistente del curso de Ciberseguridad", style = MaterialTheme.typography.bodyMedium)

        OutlinedTextField(
            value = codigo,
            onValueChange = { codigo = it },
            label = { Text("Código de estudiante") },
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            Button(
                onClick = { enviar("Muéstrame mis datos de matrícula en el curso.") },
                modifier = Modifier.weight(1f)
            ) { Text("Matrícula") }
            Button(
                onClick = { enviar("¿Cuál es mi estado académico actual?") },
                modifier = Modifier.weight(1f)
            ) { Text("Estado") }
        }
        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            Button(
                onClick = { enviar("Haz la proyección: ¿qué nota necesito en lo que falta para aprobar?") },
                modifier = Modifier.weight(1f)
            ) { Text("Proyección") }
            Button(
                onClick = { enviar("Dame recomendaciones concretas para estudiar esta semana.") },
                modifier = Modifier.weight(1f)
            ) { Text("Consejos") }
        }

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            OutlinedTextField(
                value = pregunta,
                onValueChange = { pregunta = it },
                label = { Text("Otra pregunta") },
                modifier = Modifier.weight(1f)
            )
            OutlinedButton(onClick = {
                if (pregunta.isNotBlank()) { enviar(pregunta); pregunta = "" }
            }) { Text("Enviar") }
        }

        Card(modifier = Modifier.fillMaxWidth().weight(1f)) {
            Column(modifier = Modifier.padding(12.dp).verticalScroll(rememberScrollState())) {
                if (cargando) {
                    CircularProgressIndicator()
                    Text("Consultando al agente...", modifier = Modifier.padding(top = 8.dp))
                } else {
                    Text(respuesta)
                }
            }
        }
    }
}