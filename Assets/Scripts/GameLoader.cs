using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
public class GameLoader : MonoBehaviour
{
    public ScriptReader scriptReader;
    public string saveName = "savedGame";
    public string directoryName = "Saves";

    public void LoadFromFile()
    {
        try
        {
            string filePath = Path.Combine(Application.persistentDataPath, directoryName, saveName + ".bin");
            
            if (File.Exists(filePath))
            {
                SaveGameData loadData;
                using (FileStream saveFile = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read))
                {
                    BinaryFormatter formatter = new BinaryFormatter();
                    loadData = (SaveGameData)formatter.Deserialize(saveFile);
                }

                scriptReader.LoadSavedStoryState(loadData);
                Debug.Log("Game loaded successfully!");
            }
            else
            {
                Debug.LogWarning("No save file found!");
            }
        }
        catch (System.Exception e)
        {
            Debug.LogError($"Failed to load game: {e.Message}");
        }
    }
}
