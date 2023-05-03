package com.gusrylmubarok.notes.domain.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.gusrylmubarok.notes.ui.theme.BabyBlue
import com.gusrylmubarok.notes.ui.theme.LightGreen
import com.gusrylmubarok.notes.ui.theme.RedOrange
import com.gusrylmubarok.notes.ui.theme.RedPink
import com.gusrylmubarok.notes.ui.theme.Violet

@Entity
data class Note(
    @PrimaryKey
    val id: Int? = null,
    val title: String,
    val content: String,
    val timestamp: Long,
    val color: Int,
) {
    companion object {
        val noteColors = listOf(RedOrange, LightGreen, Violet, BabyBlue, RedPink)
    }
}
