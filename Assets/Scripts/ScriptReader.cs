using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;
using TMPro;

public class ScriptReader : MonoBehaviour
{
    [SerializeField]
    private TextAsset _inkJsonFile;
    private Story _StoryScript;
    
    public TMP_Text dialogueBox;
    public TMP_Text nameTag;
    public TMP_Text trustLevel;
    public TMP_Text mentalState;
    public TMP_Text supplies;
    public TMP_Text archetype;

    public SoundManager soundManager;

    [SerializeField]
    private GridLayoutGroup choiceHolder;
    [SerializeField]
    private Button choiceBasePrefab;

    public Image characterIcon;

    private string currentMusic = "";
    void Start()
    {
        LoadStory();
    }

    void LoadStory()
    {
        _StoryScript = new Story(_inkJsonFile.text);

        _StoryScript.BindExternalFunction("Name", (string charName) => ChangeName(charName));
        _StoryScript.BindExternalFunction("TrustLevel", (int trustLevel) => ChangeTrustLevel(trustLevel));
        _StoryScript.BindExternalFunction("MentalState", (int mentalState) => ChangeMentalState(mentalState));
        _StoryScript.BindExternalFunction("Supplies", (int supplies) => ChangeSupplies(supplies));
        _StoryScript.BindExternalFunction("Archetype", (string archetype) => ChangeArchetype(archetype));
        _StoryScript.BindExternalFunction("Play", (string musicName) => PlayBackgroundMusic(musicName));
        _StoryScript.BindExternalFunction("Sound", (string soundName) => PlaySoundEffect(soundName));
    }

    public void DisplayNextLine()
    {   
        if (_StoryScript.canContinue)
        {
            string text = _StoryScript.Continue();
            text = text?.Trim();
            dialogueBox.text = text;
        }
        else if (_StoryScript.currentChoices.Count >  0)
        {
            DisplayChoices();
        }
        else
        {
            dialogueBox.text = "That's all, folks!";
        }
    }

    private void DisplayChoices()
    {
            if(choiceHolder.GetComponentsInChildren<Button>().Length > 0) return;
            for (int i = 0; i < _StoryScript.currentChoices.Count; i++)
            {
                var choice = _StoryScript.currentChoices[i];
                var button = CreateChoiceButton(choice.text);

                button.onClick.AddListener(() => OnClickChoiceButton(choice));
            }
    }

    Button CreateChoiceButton(string choice)
    {

        var choiceButton = Instantiate(choiceBasePrefab);
        choiceButton.transform.SetParent(choiceHolder.transform, false);

        var buttonText = choiceButton.GetComponentInChildren<TMP_Text>();
        buttonText.text = choice;

        return choiceButton;
    }

    void OnClickChoiceButton(Choice choice)
    {
        _StoryScript.ChooseChoiceIndex(choice.index);
        RefreshChoiceView();
        DisplayNextLine();
    }

    void RefreshChoiceView()
    {
        if (choiceHolder != null)
        {
            foreach (var button in choiceHolder.GetComponentsInChildren<Button>())
            {
                Destroy(button.gameObject);
            }
        }
    }
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            DisplayNextLine();
        }
    }

    public void ChangeName(string name)
    {
        string SpeakerName = name;

        nameTag.text = SpeakerName;

        var charIcon = Resources.Load<Sprite>("CharacterIcons/" + SpeakerName);
        if (charIcon != null)
        {
            characterIcon.sprite = charIcon;
        }
    }

    public void ChangeTrustLevel(int trust)
    {
        string TrustLevel = trust.ToString();

        trustLevel.text = "Trust: " + TrustLevel;
    }
    
    public void ChangeMentalState(int mental)
    {
        string MentalState = mental.ToString();

        mentalState.text = "Mental State: " + MentalState;
    }
    public void ChangeSupplies(int supply)
    {
        string Supplies = supply.ToString();

        supplies.text = "Supplies: " + Supplies;
    }
    public void ChangeArchetype(string arch)
    {
        string Archetype = arch;

        archetype.text = "Archetype: " + Archetype;
    }

    void PlayBackgroundMusic(string musicName)
    {
        PlayMusicIfChanged(musicName);
    }

    void PlaySoundEffect(string soundName)
    {
        soundManager.PlaySoundEffect(soundName);
    }
    void PlayMusicIfChanged(string newMusic)
    {
        if (currentMusic != newMusic)
        {
            soundManager.PlayBackgroundMusic(newMusic);
            currentMusic = newMusic; 
        }
    }
    public void SaveCurrentStoryState(SaveGameData saveData)
    {
        saveData.trustLevel = (int)_StoryScript.variablesState["trustLevel"];
        saveData.mentalState = (int)_StoryScript.variablesState["mentalState"];
        saveData.supplies = (int)_StoryScript.variablesState["supplies"];
        saveData.archetype = (string)_StoryScript.variablesState["archetype"];
        saveData.currentMusic = currentMusic;
        saveData.inkStoryState = _StoryScript.state.ToJson();
    }
    public void LoadSavedStoryState(SaveGameData loadData)
    {
        if (_StoryScript == null) 
        {
            _StoryScript = new Story(_inkJsonFile.text); 
        }

        _StoryScript.state.LoadJson(loadData.inkStoryState);

        ChangeTrustLevel(loadData.trustLevel);
        ChangeMentalState(loadData.mentalState);
        ChangeSupplies(loadData.supplies);
        ChangeArchetype(loadData.archetype);

        if (!string.IsNullOrEmpty(loadData.currentMusic))
        {
            soundManager.PlayBackgroundMusic(loadData.currentMusic);
        }

        DisplayNextLine(); 
    }

}
