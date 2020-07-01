package durban77.betukereso

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val btn = findViewById<Button>(R.id.keres)
        btn.setOnClickListener {
            findViewById<TextView>(R.id.results).text = "..."
            val inputChars = findViewById<TextView>(R.id.characters).text
            val topList = TopList()
            var chars = inputChars.toString().toLowerCase().replace("[^a-záéíóöőúüű]".toRegex(), "")
            if (!findViewById<TextView>(R.id.characters).text.equals(chars.toUpperCase()))
                findViewById<TextView>(R.id.characters).text = chars.toUpperCase()
            resources.openRawResource(R.raw.hunwords).bufferedReader().useLines({ it ->
                val iter = it.iterator();
                while (iter.hasNext()) {
                    val word = iter.next()
                    val score = getScore(word, chars)
                    if (score < Int.MAX_VALUE)
                        topList.insertOrSkip(ScoredWord(score, word))
                }
            })
            findViewById<TextView>(R.id.results).text = topList.toString().replace(',','\n').replace('[',' ').replace(']', ' ')
        }
    }
    fun getScore(text: String, initialFullSet:String): Int {
        var fullset = initialFullSet;
        text.toCharArray().iterator().forEach { t: Char ->  if (fullset.contains(t, false)) {
            fullset = fullset.replaceFirst(
                t,
                '*'
            )
        } else {
            return Int.MAX_VALUE
        }}
        return fullset.replace("*","").length
    }
    class ScoredWord {
        constructor(score: Int, word: String) {
            this.score = score
            this.word = word
        }

        var score:Int = Int.MAX_VALUE
        var word:String = ""

        override fun toString(): String {
            return ""+score+"   "+word
        }
    }
    class TopList() : LinkedList<ScoredWord>() {
        var limit:Int=10
        fun insertOrSkip(newItem: ScoredWord) {
            if (newItem.score < Int.MAX_VALUE) {
                add(newItem)
                sortBy { it.score }
                if (this.size > this.limit) {
                    removeLast()
                }
            }
        }
    }
}