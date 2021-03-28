// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "!OdinShader!"
{
	Properties
	{
		_ColorMap("Color Map!", 2D) = "white" {}
		_smoothnesscolor("smoothness color", Color) = (1,1,1,0)
		_smoothnesintesity("smoothnes intesity", Range( 0 , 4)) = 0
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Primarycolor("Primary color", Color) = (0.4056604,0.4056604,0.4056604,0)
		_Secondarycolor("Secondary color", Color) = (0.9716981,0.9595354,0.5821022,0)
		_Terciarycolor("Terciary color", Color) = (0.9992574,1,0.6839622,0)
		_Accentcolor("Accent color", Color) = (0.1462264,0.9065037,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _ColorMap;
		uniform float4 _ColorMap_ST;
		uniform float4 _Accentcolor;
		uniform float4 _Primarycolor;
		uniform float4 _Secondarycolor;
		uniform float4 _Terciarycolor;
		uniform float4 _smoothnesscolor;
		uniform float _smoothnesintesity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_ColorMap = i.uv_texcoord * _ColorMap_ST.xy + _ColorMap_ST.zw;
			float4 tex2DNode19_g110 = tex2D( _ColorMap, uv_ColorMap );
			float4 Accentcolor57_g108 = _Accentcolor;
			float4 Primarycolor54_g108 = _Primarycolor;
			float4 Secondarycolor55_g108 = _Secondarycolor;
			float4 TerciaryColor56_g108 = _Terciarycolor;
			float4 MaiDIffuseOut75_g108 = ( ( tex2DNode19_g110.a * Accentcolor57_g108 ) + ( tex2DNode19_g110.r * Primarycolor54_g108 ) + ( tex2DNode19_g110.g * Secondarycolor55_g108 ) + ( tex2DNode19_g110.b * TerciaryColor56_g108 ) );
			o.Albedo = MaiDIffuseOut75_g108.rgb;
			o.Metallic = tex2D( _ColorMap, uv_ColorMap ).a;
			o.Smoothness = ( _smoothnesscolor * _smoothnesintesity ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
891.5;674.5;933;304;-1957.201;-725.8293;1.3;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;19;1202.625,932.0259;Inherit;True;Property;_ColorMap;Color Map!;0;0;Create;True;0;0;0;False;0;False;982175539796dcc4597291d5c2d73751;982175539796dcc4597291d5c2d73751;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;83;1461.187,951.9113;Inherit;False;ColorMap;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ColorNode;40;1234.126,-146.4907;Inherit;False;Property;_Primarycolor;Primary color;25;0;Create;True;0;0;0;False;0;False;0.4056604,0.4056604,0.4056604,0;0.08490568,0.08490568,0.08490568,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;43;1210.726,346.2087;Inherit;False;Property;_Accentcolor;Accent color;28;0;Create;True;0;0;0;False;0;False;0.1462264,0.9065037,1,0;0.3301886,0.3301886,0.3301886,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;42;1218.525,185.0093;Inherit;False;Property;_Terciarycolor;Terciary color;27;0;Create;True;0;0;0;False;0;False;0.9992574,1,0.6839622,0;0.9992574,1,0.6839622,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;41;1219.825,19.90918;Inherit;False;Property;_Secondarycolor;Secondary color;26;0;Create;True;0;0;0;False;0;False;0.9716981,0.9595354,0.5821022,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;85;1990.082,528.4446;Inherit;False;83;ColorMap;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;2318.622,1069.219;Inherit;False;83;ColorMap;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ColorNode;82;2948.017,1318.185;Inherit;False;Property;_smoothnesscolor;smoothness color;22;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;81;3151.583,1458.979;Inherit;False;Property;_smoothnesintesity;smoothnes intesity;23;0;Create;True;0;0;0;False;0;False;0;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;75;2204.439,579.1955;Inherit;False;Mai WireframeGen!;1;;108;3777be207e3b80c4ba51feccc86e5e6d;0;31;36;COLOR;0,0,0,0;False;1;SAMPLER2D;0,0,0,0;False;21;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;5;SAMPLER2D;0;False;6;SAMPLER2D;0;False;7;SAMPLER2D;0;False;8;COLOR;0,0,0,0;False;9;SAMPLER2D;0;False;22;COLOR;0,0,0,0;False;10;SAMPLER2D;0;False;12;SAMPLER2D;0,0,0,0;False;13;SAMPLER1D;0,0,0,0;False;14;SAMPLER2D;0,0,0,0;False;15;SAMPLER2D;0,0,0,0;False;16;COLOR;0,0,0,0;False;17;COLOR;0,0,0,0;False;18;COLOR;0,0,0,0;False;19;COLOR;0,0,0,0;False;20;COLOR;0,0,0,0;False;11;SAMPLER2D;0;False;23;FLOAT;0;False;26;FLOAT;0;False;27;FLOAT;0;False;28;FLOAT;0;False;29;FLOAT;0;False;30;FLOAT;0;False;31;FLOAT;0;False;32;FLOAT;0;False;33;FLOAT;0;False;34;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;3186.475,1292.674;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;76;2357.254,810.7634;Inherit;True;Property;_NormalMap;Normal Map;24;0;Create;True;0;0;0;False;0;False;-1;0183aec135635a149b482127d04ed66b;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;78;2556.084,1061.691;Inherit;True;Property;_TextureSample1;Texture Sample 1;18;0;Create;True;0;0;0;False;0;False;-1;982175539796dcc4597291d5c2d73751;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;7;3539.221,1046.31;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;!OdinShader!;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;83;0;19;0
WireConnection;75;1;85;0
WireConnection;75;16;40;0
WireConnection;75;17;41;0
WireConnection;75;18;42;0
WireConnection;75;19;43;0
WireConnection;80;0;82;0
WireConnection;80;1;81;0
WireConnection;78;0;86;0
WireConnection;7;0;75;0
WireConnection;7;1;76;0
WireConnection;7;3;78;4
WireConnection;7;4;80;0
ASEEND*/
//CHKSM=905CCAB6C2AC2E011F8227F2A43B19559E2FDAA4