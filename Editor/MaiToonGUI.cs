#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;


//This is my super duper cute GUI
//Its very cute, yes..... yes it is!
public class MaiWedgeGUI : ShaderGUI
{
    private Font CuteFont = (Font)Resources.Load(@"maiYeyey_font");
    private Font VrchatFont = (Font)Resources.Load(@"maisegoesc");
    private Texture2D bannerTex = Resources.Load<Texture2D>("maiheaderpink");
    private Texture2D patreonlogo = Resources.Load<Texture2D>("maipatreonlogo");
    private Texture2D discordlogo = Resources.Load<Texture2D>("maidiscordlogo");
    private Texture2D youtubelogo = Resources.Load<Texture2D>("maiyoutubelogo");
    private Texture2D pinkbunnylogo = Resources.Load<Texture2D>("pinkbunnylogo");
    private Texture2D MaiInfo = Resources.Load<Texture2D>("IMG/MaiInfo");

    private Texture2D maiheaderimg = Resources.Load<Texture2D>("IMG/MaiHeaderwedge");



    

    private MaterialProperty _Tint;
    private MaterialProperty _NoiseMapStrength;
    private MaterialProperty _EyeType1;
    private MaterialProperty _EyeType2;
    private MaterialProperty _EyeType3;
    private MaterialProperty _RingPanner;
    private MaterialProperty _NoiseMap;
    private MaterialProperty _Texture1;
    private MaterialProperty _Texture0;
    private MaterialProperty _emiss;
    private MaterialProperty _RingPannerSpeed;    
    private MaterialProperty _BaseTexture;
    
    private MaterialProperty _NoiseMapSize;
    private MaterialProperty __dirty;

    private void DrawInfo(string text1, string text2, string URL)
    {
        GUIStyle rateTxt = new GUIStyle { font = CuteFont };
        rateTxt.alignment = TextAnchor.LowerLeft;
        rateTxt.normal.textColor = new Color(0.9f, 0.9f, 0.9f);
        rateTxt.fontSize = 14;
        rateTxt.padding = new RectOffset(0, 1, 0, 1);

        GUIStyle title = new GUIStyle(rateTxt);
        title.normal.textColor = new Color(1f, 0.89f, 0.98f);
        title.alignment = TextAnchor.MiddleCenter;
        title.fontSize = 24;

        EditorGUILayout.BeginVertical("GroupBox");
        var rect = GUILayoutUtility.GetRect(0, int.MaxValue, 100, 500);
        EditorGUI.DrawPreviewTexture(rect, MaiInfo, null, ScaleMode.ScaleAndCrop);

        EditorGUI.LabelField(rect, text2, rateTxt);
        EditorGUI.LabelField(rect, text1, title);

        if (GUI.Button(rect, "", new GUIStyle()))
        {
            Application.OpenURL(URL);
        }

        EditorGUILayout.EndVertical();
    }

    private void DrawBanner(string text1, string text2, string URL)
    {
        GUIStyle rateTxt = new GUIStyle { font = CuteFont };
        rateTxt.alignment = TextAnchor.LowerRight;
        rateTxt.normal.textColor = new Color(0.9f, 0.9f, 0.9f);
        rateTxt.fontSize = 14;
        rateTxt.padding = new RectOffset(0, 1, 0, 1);

        GUIStyle title = new GUIStyle(rateTxt);
        title.normal.textColor = new Color(1f, 0.89f, 0.98f);
        title.alignment = TextAnchor.MiddleCenter;
        title.fontSize = 24;

        EditorGUILayout.BeginVertical("GroupBox");
        var rect = GUILayoutUtility.GetRect(0, int.MaxValue, 100, 500);
        EditorGUI.DrawPreviewTexture(rect, maiheaderimg, null, ScaleMode.ScaleAndCrop);

        EditorGUI.LabelField(rect, text2, rateTxt);
        EditorGUI.LabelField(rect, text1, title);

        if (GUI.Button(rect, "", new GUIStyle()))
        {
            Application.OpenURL(URL);
        }

        EditorGUILayout.EndVertical();
    }

        private void MaiBannor(string text1, string text2, string URL)//
    {
        
        GUIStyle rateTxt = new GUIStyle { font = VrchatFont };
        rateTxt.alignment = TextAnchor.LowerRight;
        rateTxt.normal.textColor = new Color(0.9f, 0.9f, 0.9f);
        rateTxt.fontSize = 12;
        rateTxt.padding = new RectOffset(0, 1, 0, 1);

        GUIStyle title = new GUIStyle(rateTxt);
        title.normal.textColor = new Color(1f, 1f, 1f);
        title.alignment = TextAnchor.MiddleCenter;
        title.fontSize = 18;

        EditorGUILayout.BeginVertical("GroupBox");
        var rect = GUILayoutUtility.GetRect(0, int.MaxValue, 100, 500);
        EditorGUI.DrawPreviewTexture(rect, MaiInfo, null, ScaleMode.ScaleAndCrop );//ScaleMode.ScaleAndCrop

        EditorGUI.LabelField(rect, text2, rateTxt);
        EditorGUI.LabelField(rect, text1, title);

        if (GUI.Button(rect, "", new GUIStyle()))
        {
            Application.OpenURL(URL);
        }

        EditorGUILayout.EndVertical();

    }
    private void DrawMaiButton(string buttonName, string buttonURL, Texture2D buttonicon)
        {

                EditorGUILayout.Space();
                



                if(GUILayout.Button(new GUIContent(buttonName, buttonicon)))
                {
                    Application.OpenURL(buttonURL);
                }


            
        }



    public override void OnGUI(MaterialEditor editor, MaterialProperty[] properties)
    {
        Material material = editor.target as Material;

        DrawBanner("Wedge Eye Shader!", "Open Shader Guide", "https://pinkbunny.tech/?p=411");

        FindProperties(properties);

        EditorGUILayout.BeginVertical("GroupBox");



        MaiSub("Eye Mode!"); 
        editor.ShaderProperty(_EyeType1, "Eye Mode 1"); //maiadd
        editor.ShaderProperty(_EyeType2, "Eye Mode 2"); //maiadd
        editor.ShaderProperty(_EyeType3, "Eye Mode 3"); //maiadd

        MaiSub("Main settings!"); 
        editor.ShaderProperty(_Tint, MakeLabel(_Tint)); //maiadd

        editor.ShaderProperty(_RingPanner, MakeLabel(_RingPanner)); //maiadd


        editor.ShaderProperty(_NoiseMapStrength, "Noise Strength"); //maiadd
        editor.ShaderProperty(_emiss, "Emission"); //maiadd


        EditorGUILayout.EndVertical();

        DrawInfo("Info", "Open Patreon", "https://www.patreon.com/Mai_Lofi");


        DrawCredits();

    }

    private static GUIContent MakeLabel(MaterialProperty property, string tooltip = null)
    {
        GUIContent staticLabel = new GUIContent();
        staticLabel.text = property.displayName;
        staticLabel.tooltip = tooltip;
        return staticLabel;
    }

    private void FindProperties(MaterialProperty[] properties)
    {

        //mai-add
        _Tint = FindProperty("_Tint", properties);
        _NoiseMapStrength = FindProperty("_NoiseMapStrength", properties);
        _EyeType1 = FindProperty("_EyeType1", properties);
        _EyeType2 = FindProperty("_EyeType2", properties);
        _EyeType3 = FindProperty("_EyeType3", properties);
        _RingPanner = FindProperty("_RingPanner", properties);
        _emiss = FindProperty("_emiss", properties);
        _RingPannerSpeed = FindProperty("_RingPannerSpeed", properties);
        _NoiseMapSize = FindProperty("_NoiseMapSize", properties);
        __dirty = FindProperty("__dirty", properties);

    }

    private void DrawCredits()
    {
        EditorGUILayout.BeginVertical("GroupBox");

        var TextStyle = new GUIStyle { font = VrchatFont, fontSize = 15, fontStyle = FontStyle.Italic };
        GUILayout.Label("Shader made with love by:", TextStyle);
        GUILayout.Space(2);
        GUILayout.Label("Mai Lofi#0348", TextStyle);
        GUILayout.Space(6);

        DrawMaiButton("    more free assets on my website!", "https://pinkbunny.tech", pinkbunnylogo);
        DrawMaiButton("    s-support pwetty pwease ( >ω<)♡(>ω< ✿)", "https://www.patreon.com/Mai_Lofi", patreonlogo);
        DrawMaiButton("    kons, lofi, raids, and creation help!", "https://discord.gg/mTZ5h9hqMb", discordlogo);
        DrawMaiButton("    tutorials n stuff", "https://www.youtube.com/channel/UC4kwlkzebOFQOMENUaacgdg", youtubelogo);

        GUILayout.Label("Stay UWU my friends...", TextStyle);


  

        EditorGUILayout.EndVertical();
    }

    private void Header(string name)
    {
        var Style = new GUIStyle { font = VrchatFont, fontSize = 18, fontStyle = FontStyle.Italic, alignment = TextAnchor.MiddleLeft };
        GUILayout.Label(name, Style);
        GUILayout.Space(5);
    }
    private void MaiSub(string name)
    {
        var Style = new GUIStyle { font = VrchatFont, fontSize = 15, fontStyle = FontStyle.Italic, alignment = TextAnchor.MiddleLeft };
        GUILayout.Space(3);
        var rect = GUILayoutUtility.GetRect(0, int.MaxValue, 6, 35);
        EditorGUI.DrawPreviewTexture(rect, bannerTex, null, ScaleMode.ScaleAndCrop);
        GUILayout.Space(2);
        GUILayout.Label(name, Style);
        GUILayout.Space(2);
    }
}
#endif