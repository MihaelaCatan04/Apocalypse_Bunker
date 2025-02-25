using UnityEngine;

public class SoundManager : MonoBehaviour
{
    public AudioSource backgroundMusic;
    public AudioSource soundEffect;
    public void PlayBackgroundMusic(string musicName)
    {
        AudioClip clip = Resources.Load<AudioClip>("Audio/" + musicName);
        if (clip != null)
        {
            backgroundMusic.clip = clip;
            backgroundMusic.Play();
        }
        // else 
        // {
        //     Debug.LogError($"SoundManager: Failed to load audio clip '{clip}' from Resources/Audio/");

        // }

    }

    public void PlaySoundEffect(string soundName)
    {
        AudioClip clip = Resources.Load<AudioClip>("Audio/" + soundName);
        Debug.Log(clip);
        if (clip != null)
        {
            soundEffect.PlayOneShot(clip);
        }
    }

    public void StopBackgroundMusic()
    {
        backgroundMusic.Stop();
    }
}
