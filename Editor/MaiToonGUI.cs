#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;


//This is my super duper cute GUI
//Its very cute, yes..... yes it is!
public class MaiToonGUI : ShaderGUI
{
    private Font CuteFont = (Font)Resources.Load(@"maiYeyey_font");
    private Font VrchatFont = (Font)Resources.Load(@"maisegoesc");
    private Texture2D bannerTex = Resources.Load<Texture2D>("maiheaderpink");
    private Texture2D patreonlogo = Resources.Load<Texture2D>("maipatreonlogo");
    private Texture2D discordlogo = Resources.Load<Texture2D>("maidiscordlogo");
    private Texture2D youtubelogo = Resources.Load<Texture2D>("maiyoutubelogo");
    private Texture2D pinkbunnylogo = Resources.Load<Texture2D>("pinkbunnylogo");
    private Texture2D MaiInfo = Resources.Load<Texture2D>("IMG/MaiInfo");

    private Texture2D maiheaderimg = Resources.Load<Texture2D>("IMG/MaiHeadertoonv1");



    

    private MaterialProperty _Rampmap;
    private MaterialProperty _Shadowamount;
    private MaterialProperty _Tint;
    private MaterialProperty _MainTex;
//    private MaterialProperty _MainTex_ST;
    private MaterialProperty _OverallBrightnessAdjust;
    private MaterialProperty _RimSharpness;
    private MaterialProperty _RimOffset;
    private MaterialProperty _rimmask;
//    private MaterialProperty _rimmask_ST;
    private MaterialProperty _rimcolor;
    private MaterialProperty _Rimeviormentcolorlevel;
    private MaterialProperty _Highlightsharpness;
    private MaterialProperty _HighlightOffset;
    private MaterialProperty _HighlightMap;
    private MaterialProperty _EmissionLevel;
    private MaterialProperty _HighlightTint;
    private MaterialProperty _EnviormentLightingcolorlevel;
    private MaterialProperty _HighlightIntencity;
    private MaterialProperty _Blendoutlinecolorwithtexture;
    private MaterialProperty _OutlineColor;
    private MaterialProperty _Outlinemask;

    //new rampmaps
    //private MaterialProperty _Rampmap0;
    private MaterialProperty _Rampmap1;
    private MaterialProperty _Rampmap2;
    private MaterialProperty _Rampmap3;
    private MaterialProperty _Rampmap4;
    private MaterialProperty _Rampmap5;
    private MaterialProperty _Rampmap6;
    private MaterialProperty _Rampmap7;
    private MaterialProperty _Rampmap8;

    private MaterialProperty _TextureSelection;
//    private MaterialProperty _Cutoff = 0.5;
    private MaterialProperty _OutlineThickness;

    private MaterialProperty _EmissionMask;

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

        DrawBanner("Mai Toon Shader Beta 1.1!", "Open Shader Guide WIP", "https://pinkbunny.tech/?p=411");

        FindProperties(properties);

        EditorGUILayout.BeginVertical("GroupBox");



        MaiSub("Main"); 
        editor.ShaderProperty(_MainTex, "Main Texture"); //maiadd
        editor.ShaderProperty(_Tint, "Tint"); //maiadd
        editor.ShaderProperty(_OverallBrightnessAdjust, "Brightness Adjust"); //maiadd

        MaiSub("Shadow"); 
        editor.ShaderProperty(_TextureSelection, "Toon Ramp"); //maiadd
        editor.ShaderProperty(_Shadowamount, "Shadow adjust"); //maiadd

        MaiSub("Rim Lighting"); 
        editor.ShaderProperty(_rimmask, "Rim Mask"); //maiadd
        editor.ShaderProperty(_RimOffset, "Offset"); //maiadd
        editor.ShaderProperty(_RimSharpness, "Sharpness"); //maiadd
        editor.ShaderProperty(_rimcolor, "Color"); //maiadd

        MaiSub("Highlight"); 
        editor.ShaderProperty(_HighlightMap, "Highlight Mask"); //maiadd
        editor.ShaderProperty(_Highlightsharpness, "Sharpness"); //maiadd
        editor.ShaderProperty(_HighlightIntencity, "Intencity"); //maiadd
        editor.ShaderProperty(_HighlightTint, "Color"); //maiadd


        MaiSub("Outline"); 
        editor.ShaderProperty(_Outlinemask, "Outline Mask"); //maiadd
        editor.ShaderProperty(_OutlineThickness, "Thickness"); //maiadd
        editor.ShaderProperty(_OutlineColor, "Color"); //maiadd
        editor.ShaderProperty(_Blendoutlinecolorwithtexture, "Blend Outline with texture (recomended)"); //maiadd

        MaiSub("Enviorment Color"); 
        editor.ShaderProperty(_Rimeviormentcolorlevel, "Rim Enviorment Color Level"); //maiadd
        editor.ShaderProperty(_EnviormentLightingcolorlevel, "Highlight Enviorment Color Level"); //maiadd



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
        //_Rampmap = FindProperty("_Rampmap", properties);

        //new rampmap stuff
        _Rampmap = FindProperty("_Rampmap0", properties);
        _Rampmap = FindProperty("_Rampmap1", properties);
        _Rampmap = FindProperty("_Rampmap2", properties);
        _Rampmap = FindProperty("_Rampmap3", properties);
        _Rampmap = FindProperty("_Rampmap4", properties);
        _Rampmap = FindProperty("_Rampmap5", properties);
        _Rampmap = FindProperty("_Rampmap6", properties);
        _Rampmap = FindProperty("_Rampmap7", properties);
        _Rampmap = FindProperty("_Rampmap8", properties);

        _Shadowamount = FindProperty("_Shadowamount", properties);
        _Tint = FindProperty("_Tint", properties);
        _MainTex = FindProperty("_MainTex", properties);
        _OverallBrightnessAdjust = FindProperty("_OverallBrightnessAdjust", properties);
        _RimSharpness = FindProperty("_RimSharpness", properties);
        _RimOffset = FindProperty("_RimOffset", properties);
        _rimmask = FindProperty("_rimmask", properties);
        _EmissionLevel = FindProperty("_EmissionLevel", properties);
        _rimcolor = FindProperty("_rimcolor", properties);
        _Rimeviormentcolorlevel = FindProperty("_Rimeviormentcolorlevel", properties);
        _Highlightsharpness = FindProperty("_Highlightsharpness", properties);
        _HighlightOffset = FindProperty("_HighlightOffset", properties);
        _HighlightMap = FindProperty("_HighlightMap", properties);
//        _HighlightMap_ST = FindProperty("_HighlightMap_ST", properties);
        _HighlightTint = FindProperty("_HighlightTint", properties);
        _EnviormentLightingcolorlevel = FindProperty("_EnviormentLightingcolorlevel", properties);
        _HighlightIntencity = FindProperty("_HighlightIntencity", properties);
        _Blendoutlinecolorwithtexture = FindProperty("_Blendoutlinecolorwithtexture", properties);
        _OutlineColor = FindProperty("_OutlineColor", properties);
        _Outlinemask = FindProperty("_Outlinemask", properties);
//        _Outlinemask_ST = FindProperty("_Outlinemask_ST", properties);
        _TextureSelection = FindProperty("_TextureSelection", properties);
        _OutlineThickness = FindProperty("_OutlineThickness", properties);

        _EmissionMask = FindProperty("_EmissionMask", properties);
        

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