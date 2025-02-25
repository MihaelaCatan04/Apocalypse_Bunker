using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
public class SaveGame : MonoBehaviour
{
    public ScriptReader scriptReader;
    public string saveName = "savedGame";
    public string directoryName = "Saves";
    public SaveGameData saveGameData;

    private void Start()
    {
        saveGameData = new SaveGameData();
    }

    public void SaveToFile()
    {
        try
        {
            // Get current story state
            scriptReader.SaveCurrentStoryState(saveGameData);

            // Create directory if needed
            string directoryPath = Path.Combine(Application.persistentDataPath, directoryName);
            if (!Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }

            // Save to file with proper sharing mode
            string filePath = Path.Combine(directoryPath, saveName + ".bin");
            using (FileStream saveFile = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.None))
            {
                BinaryFormatter formatter = new BinaryFormatter();
                formatter.Serialize(saveFile, saveGameData);
            }

            Debug.Log("Game saved successfully!");
        }
        catch (System.Exception e)
        {
            Debug.LogError($"Failed to save game: {e.Message}");
        }
    }
}
