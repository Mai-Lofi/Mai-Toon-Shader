// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "!Mai Lofi!/Mai Toon Shader!"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		_Tint("Tint", Color) = (0.7830188,0.7830188,0.7830188,0)
		_OverallBrightnessAdjust("Overall Brightness Adjust", Range( 0 , 2)) = 0.6
		[KeywordEnum(None,Key1,Key2,Key3,Key4,Key5)] _TextureSelection("Texture Selection", Float) = 0
		[HideInInspector]_Rampmap0("Ramp map 0", 2D) = "white" {}
		_Shadowamount("Shadow amount", Range( 0 , 0.5)) = 0.5
		_rimmask("rim mask", 2D) = "white" {}
		_RimOffset("Rim Offset", Range( 0 , 1)) = 0.537
		_rimcolor("rim color", Color) = (1,1,1,0)
		_RimSharpness("Rim Sharpness", Range( 0 , 0.78)) = 0.78
		_HighlightMap("Highlight Map", 2D) = "white" {}
		_HighlightOffset("Highlight Offset", Range( 0 , 1)) = 0.093
		_Highlightsharpness("Highlight sharpness", Range( 1.02 , 1.1)) = 1.1
		_HighlightIntencity("Highlight Intencity", Range( 0 , 1)) = 0.14
		_HighlightTint("Highlight Tint", Color) = (0.8679245,0.8679245,0.8679245,0)
		_OutlineThickness("Outline Thickness", Float) = 200
		_Outlinemask("Outline mask", 2D) = "white" {}
		_OutlineColor("Outline Color", Color) = (0.3396226,0.1783884,0.05927376,0)
		[Toggle]_Blendoutlinecolorwithtexture("Blend outline color with texture", Float) = 1
		_Rimeviormentcolorlevel("Rim eviorment color level", Range( 0 , 1)) = 0
		_EnviormentLightingcolorlevel("Enviorment Lighting color level", Range( 0 , 1)) = 0
		[HideInInspector]_Rampmap1("Ramp map 1", 2D) = "white" {}
		[HideInInspector]_Rampmap2("Ramp map 2", 2D) = "white" {}
		[HideInInspector]_Rampmap3("Ramp map 3", 2D) = "white" {}
		[HideInInspector]_Rampmap4("Ramp map 4", 2D) = "white" {}
		[HideInInspector]_Rampmap5("Ramp map 5", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float VertexPaint120 = ( v.color.r * 1.0 );
			float outlineVar = ( 1E-05 * _OutlineThickness * VertexPaint120 );
			v.vertex.xyz += ( v.normal * outlineVar );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode36 = tex2D( _MainTex, uv_MainTex );
			float4 maintexture39 = ( _Tint * tex2DNode36 );
			float Alpha122 = tex2DNode36.a;
			float2 uv_Outlinemask = i.uv_texcoord * _Outlinemask_ST.xy + _Outlinemask_ST.zw;
			o.Emission = (( _Blendoutlinecolorwithtexture )?( ( maintexture39 * _OutlineColor ) ):( _OutlineColor )).rgb;
			clip( ( Alpha122 * tex2D( _Outlinemask, uv_Outlinemask ) ).r - _Cutoff );
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _TEXTURESELECTION_NONE _TEXTURESELECTION_KEY1 _TEXTURESELECTION_KEY2 _TEXTURESELECTION_KEY3 _TEXTURESELECTION_KEY4 _TEXTURESELECTION_KEY5
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			float2 uv_texcoord;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _Rampmap0;
		uniform float _Shadowamount;
		uniform sampler2D _Rampmap1;
		uniform sampler2D _Rampmap2;
		uniform sampler2D _Rampmap3;
		uniform sampler2D _Rampmap4;
		uniform sampler2D _Rampmap5;
		uniform float4 _Tint;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _OverallBrightnessAdjust;
		uniform float _RimSharpness;
		uniform float _RimOffset;
		uniform sampler2D _rimmask;
		uniform float4 _rimmask_ST;
		uniform float4 _rimcolor;
		uniform float _Rimeviormentcolorlevel;
		uniform float _Highlightsharpness;
		uniform float _HighlightOffset;
		uniform sampler2D _HighlightMap;
		uniform float4 _HighlightMap_ST;
		uniform float4 _HighlightTint;
		uniform float _EnviormentLightingcolorlevel;
		uniform float _HighlightIntencity;
		uniform float _Blendoutlinecolorwithtexture;
		uniform float4 _OutlineColor;
		uniform sampler2D _Outlinemask;
		uniform float4 _Outlinemask_ST;
		uniform float _Cutoff = 0.5;
		uniform float _OutlineThickness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 Outline114 = 0;
			v.vertex.xyz += Outline114;
			v.vertex.w = 1;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult3 = dot( ase_worldNormal , ase_worldlightDir );
			float NormalLightDir8 = dotResult3;
			float temp_output_33_0 = (NormalLightDir8*_Shadowamount + _Shadowamount);
			float2 temp_cast_0 = (temp_output_33_0).xx;
			float2 temp_cast_1 = (temp_output_33_0).xx;
			float2 temp_cast_2 = (temp_output_33_0).xx;
			float2 temp_cast_3 = (temp_output_33_0).xx;
			float2 temp_cast_4 = (temp_output_33_0).xx;
			float2 temp_cast_5 = (temp_output_33_0).xx;
			float2 temp_cast_6 = (temp_output_33_0).xx;
			#if defined(_TEXTURESELECTION_NONE)
				float4 staticSwitch209 = tex2D( _Rampmap0, temp_cast_0 );
			#elif defined(_TEXTURESELECTION_KEY1)
				float4 staticSwitch209 = tex2D( _Rampmap1, temp_cast_2 );
			#elif defined(_TEXTURESELECTION_KEY2)
				float4 staticSwitch209 = tex2D( _Rampmap2, temp_cast_3 );
			#elif defined(_TEXTURESELECTION_KEY3)
				float4 staticSwitch209 = tex2D( _Rampmap3, temp_cast_4 );
			#elif defined(_TEXTURESELECTION_KEY4)
				float4 staticSwitch209 = tex2D( _Rampmap4, temp_cast_5 );
			#elif defined(_TEXTURESELECTION_KEY5)
				float4 staticSwitch209 = tex2D( _Rampmap5, temp_cast_6 );
			#else
				float4 staticSwitch209 = tex2D( _Rampmap0, temp_cast_0 );
			#endif
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode36 = tex2D( _MainTex, uv_MainTex );
			float4 maintexture39 = ( _Tint * tex2DNode36 );
			float4 Shadow28 = ( staticSwitch209 * maintexture39 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_cast_7 = (0.4).xxxx;
			float4 temp_cast_8 = (1.0).xxxx;
			float4 clampResult178 = clamp( ase_lightColor , temp_cast_7 , temp_cast_8 );
			UnityGI gi168 = gi;
			float3 diffNorm168 = ase_worldNormal;
			gi168 = UnityGI_Base( data, 1, diffNorm168 );
			float3 indirectDiffuse168 = gi168.indirect.diffuse + diffNorm168 * 0.0001;
			float4 LightingReal182 = ( Shadow28 * ( clampResult178 * ( float4( ( indirectDiffuse168 * 1.0 ) , 0.0 ) + ase_lightAtten + maintexture39 + _OverallBrightnessAdjust ) ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult6 = dot( ase_worldNormal , ase_worldViewDir );
			float NormalViewDir10 = dotResult6;
			float smoothstepResult141 = smoothstep( 0.2 , ( 1.0 - _RimSharpness ) , pow( ( 1.0 - saturate( ( ( 1.0 - _RimOffset ) + NormalViewDir10 ) ) ) , 1.0 ));
			float2 uv_rimmask = i.uv_texcoord * _rimmask_ST.xy + _rimmask_ST.zw;
			float4 lerpResult130 = lerp( _rimcolor , ase_lightColor , _Rimeviormentcolorlevel);
			float4 rim60 = ( saturate( ( smoothstepResult141 * ( NormalLightDir8 * ase_lightAtten ) ) ) * ( tex2D( _rimmask, uv_rimmask ) * lerpResult130 ) );
			float dotResult91 = dot( ( ase_worldViewDir + _WorldSpaceLightPos0.xyz ) , ase_worldNormal );
			float smoothstepResult82 = smoothstep( _Highlightsharpness , 1.1 , pow( dotResult91 , _HighlightOffset ));
			float2 uv_HighlightMap = i.uv_texcoord * _HighlightMap_ST.xy + _HighlightMap_ST.zw;
			float4 lerpResult98 = lerp( _HighlightTint , ase_lightColor , _EnviormentLightingcolorlevel);
			float4 spec89 = ( ase_lightAtten * ( ( smoothstepResult82 * ( tex2D( _HighlightMap, uv_HighlightMap ) * lerpResult98 ) ) * _HighlightIntencity ) );
			c.rgb = ( ( LightingReal182 + rim60 ) + spec89 ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
226;72;1175;621;-359.5911;2064.016;1.088444;True;False
Node;AmplifyShaderEditor.CommentaryNode;12;-4193.151,-306.7504;Inherit;False;778.1763;409.3889;Mai Normal View.dir;4;7;5;6;10;view dir;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;11;-4211.635,-798.8636;Inherit;False;814.3636;388.397;Mai Normal.light;4;4;3;1;8;Normal light;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;7;-4117.483,-79.36189;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;5;-4143.15,-256.7505;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;4;-4161.636,-587.4664;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1;-4157.851,-748.8638;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;6;-3874.179,-158.0959;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;61;-1490.745,771.0637;Inherit;False;3039.772;1339.238;Comment;25;60;66;71;68;58;70;67;59;57;69;56;54;55;53;127;128;129;130;131;132;141;142;183;184;185;Rim lighting;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1455.81,866.1215;Inherit;False;Property;_RimOffset;Rim Offset;7;0;Create;True;0;0;0;False;0;False;0.537;0.537;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3663.474,-155.5623;Inherit;False;NormalViewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;3;-3816.91,-639.7443;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;35;-772.8302,-2397.401;Inherit;False;2634.436;1580.62;shadow;13;25;28;42;41;203;207;206;205;204;209;34;14;33;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;183;-1207.85,963.7065;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-1437.545,1106.882;Inherit;False;10;NormalViewDir;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;40;-1931.592,-1821.38;Inherit;False;849.54;455.985;Comment;5;37;36;38;39;122;Main tex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-3646.271,-629.7664;Inherit;False;NormalLightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-608.8392,-1642.789;Inherit;False;Property;_Shadowamount;Shadow amount;5;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;14;-546.1255,-1839.673;Inherit;False;8;NormalLightDir;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-1108.352,1079.287;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;-1791.18,-1771.38;Inherit;False;Property;_Tint;Tint;1;0;Create;True;0;0;0;False;0;False;0.7830188,0.7830188,0.7830188,0;0.7830188,0.7830188,0.7830188,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;102;-4906.651,632.9769;Inherit;False;3017.896;1101.887;Comment;22;73;76;92;74;96;97;99;81;91;93;80;83;98;101;82;86;94;88;85;87;89;189;spec;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;36;-1881.592,-1595.395;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;0;False;0;False;-1;None;9d834ecaccf26f04ab6916f281a00ba5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceLightPos;76;-4856.651,944.0024;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;56;-968.2217,995.9486;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1501.882,-1660.976;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;73;-4774.382,682.9769;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;33;-292.8395,-1724.789;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;203;181.8938,-2061.819;Inherit;True;Property;_Rampmap1;Ramp map 1;21;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;0a9f174b2cf1b8944b6aa0089504f847;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;204;189.3775,-1788.451;Inherit;True;Property;_Rampmap2;Ramp map 2;22;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;9df10fc46cf752a4c956ab97f082f154;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;92;-4752.309,1135.451;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-4489.699,745.9681;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;57;-784.2227,1015.949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1326.552,-1660.59;Inherit;False;maintexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-976.4228,1214.349;Inherit;False;Constant;_RimInsideMask;Rim Inside Mask;8;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;166;-2690.776,-1090.349;Inherit;False;1636.269;870.8802;Comment;15;182;181;180;179;178;177;176;175;174;173;172;171;170;169;168;mai lighting;1,0.5330188,0.9231067,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;116;-4248.764,-2915.184;Inherit;False;946.5361;506.308;Comment;5;121;120;119;118;117;Vertex Paint;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;207;214.5196,-1068.611;Inherit;True;Property;_Rampmap5;Ramp map 5;25;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;a8cc1c7de8df6b04dbd50c12c6a26535;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;182.176,-2303.691;Inherit;True;Property;_Rampmap0;Ramp map 0;4;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;205;202.5899,-1542.466;Inherit;True;Property;_Rampmap3;Ramp map 3;23;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;cb9f0dca5fe430740a3350e00f2cf330;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;206;211.2569,-1296.981;Inherit;True;Property;_Rampmap4;Ramp map 4;24;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;52e66a9243cdfed44b5e906f5910d35b;52e66a9243cdfed44b5e906f5910d35b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;184;-345.0723,1284.402;Inherit;False;Property;_RimSharpness;Rim Sharpness;9;0;Create;True;0;0;0;False;0;False;0.78;0.78;0;0.78;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;168;-2379.315,-607.3615;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-3427.132,1620.364;Inherit;False;Property;_EnviormentLightingcolorlevel;Enviorment Lighting color level;20;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;96;-3467.132,1318.364;Inherit;False;Property;_HighlightTint;Highlight Tint;14;0;Create;True;0;0;0;False;0;False;0.8679245,0.8679245,0.8679245,0;1,0.4103772,0.4103772,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;97;-3380.132,1478.364;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;41;1323.349,-1531.148;Inherit;False;39;maintexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-2418.89,-521.361;Inherit;False;Constant;_ShineSmoothness;Shine Smoothness;17;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;118;-4198.764,-2865.184;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;58;-496.3462,994.0887;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;69;-42.54136,1524.747;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;185;-128.0723,1183.402;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;91;-4286.309,831.451;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-333.0488,1105.91;Inherit;False;Constant;_min2;min2;12;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-4242.651,1097.002;Inherit;False;Property;_HighlightOffset;Highlight Offset;11;0;Create;True;0;0;0;False;0;False;0.093;0.093;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-3962.411,-2613.876;Inherit;False;Constant;_VertexPaint;Vertex Paint;25;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;209;740.1185,-1642.653;Inherit;True;Property;_TextureSelection;Texture Selection;3;0;Create;True;0;0;0;False;0;False;0;0;4;True;;KeywordEnum;6;None;Key1;Key2;Key3;Key4;Key5;Create;False;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;67;-58.54153,1423.747;Inherit;False;8;NormalLightDir;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;552.6231,1882.107;Inherit;False;Property;_Rimeviormentcolorlevel;Rim eviorment color level;19;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;173;-2340.822,-957.4622;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;174;-2421.707,-434.0506;Inherit;False;Property;_OverallBrightnessAdjust;Overall Brightness Adjust;2;0;Create;True;0;0;0;False;0;False;0.6;0.6;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;170;-2211.205,-1069.469;Inherit;False;Constant;_min4;min4;23;0;Create;True;0;0;0;False;0;False;0.4;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;98;-3175.132,1257.364;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-2439.642,-1038.924;Inherit;False;Constant;_max4;max4;22;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-2139.135,-577.6144;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;1456.673,-1820.125;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;128;556.6231,1576.107;Inherit;False;Property;_rimcolor;rim color;8;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;189;-3787.768,1280.709;Inherit;False;Constant;_max;max;21;0;Create;True;0;0;0;False;0;False;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;80;-4025.652,925.0026;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;172;-2344.999,-759.1905;Inherit;False;39;maintexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-3916.652,1166.002;Inherit;False;Property;_Highlightsharpness;Highlight sharpness;12;0;Create;True;0;0;0;False;0;False;1.1;1.1;1.02;1.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;141;-104.5973,977.0402;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;234.4587,1374.155;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;176;-2391.192,-324.685;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;93;-3584.228,1090.442;Inherit;True;Property;_HighlightMap;Highlight Map;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;129;599.6231,1740.107;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3709.412,-2809.876;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-3547.228,-2809.774;Inherit;False;VertexPaint;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;103;-4304.447,-2228.566;Inherit;False;1752.876;826.155;Comment;14;114;113;111;112;110;105;109;107;108;106;104;123;124;126;Outline;0,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-3048.132,1125.364;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;82;-3658.652,938.0024;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;177;-1913.877,-688.3205;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;178;-1968.35,-921.0428;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;334.735,972.7561;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1651.298,-1772.16;Inherit;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;131;395.5278,1352.185;Inherit;True;Property;_rimmask;rim mask;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;130;804.6232,1519.107;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;107;-4240.846,-2195.51;Float;False;Property;_OutlineColor;Outline Color;17;0;Create;True;0;0;0;False;0;False;0.3396226,0.1783884,0.05927376,0;0.3396225,0.1783883,0.05927371,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;108;-4205.004,-1915.817;Inherit;False;39;maintexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-1782.251,-791.8253;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;132;931.6234,1387.107;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;180;-1852.596,-1029.474;Inherit;False;28;Shadow;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-3018.228,968.4419;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-1465.747,-1490.773;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2760.55,1123.881;Inherit;False;Property;_HighlightIntencity;Highlight Intencity;13;0;Create;True;0;0;0;False;0;False;0.14;0.14;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-4266.197,-1751.275;Inherit;False;120;VertexPaint;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;71;542.0148,1022.875;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-2639.394,944.0768;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;111;-3412.753,-1647.371;Inherit;False;122;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;835.9709,1157.993;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-4002.653,-1840.931;Float;False;Property;_OutlineThickness;Outline Thickness;15;0;Create;True;0;0;0;False;0;False;200;200;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-3940.63,-2007.878;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;109;-4011.085,-1724.311;Inherit;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LightAttenuation;88;-2521.256,867.8809;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-3897.73,-1919.879;Float;False;Constant;_Float46;Float 46;17;0;Create;True;0;0;0;False;0;False;1E-05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-1512.706,-941.8278;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;124;-3781.171,-1615.456;Inherit;True;Property;_Outlinemask;Outline mask;16;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;182;-1291.075,-1004.221;Inherit;False;LightingReal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-3268.99,-1553.004;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;1305.588,1175.665;Inherit;False;rim;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-3656.258,-1803.602;Inherit;False;3;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-2378.256,982.8815;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;112;-3758.613,-2109.959;Inherit;False;Property;_Blendoutlinecolorwithtexture;Blend outline color with texture;18;0;Create;True;0;0;0;False;0;False;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;113;-3231.546,-1823.501;Inherit;False;0;True;Masked;0;0;Front;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-749.9981,-65.50178;Inherit;False;182;LightingReal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-2133.256,1004.881;Inherit;False;spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-765.2357,52.61805;Inherit;False;60;rim;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-515.0609,-39.50338;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-2799.592,-1821.53;Inherit;False;Outline;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;90;-600.726,205.1093;Inherit;False;89;spec;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;121;-3948.825,-2810.652;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-284.9568,372.878;Inherit;False;114;Outline;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-326.8104,47.02544;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;!Mai Lofi!/Mai Toon Shader!;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0.6603774,0.6603774,0.6603774,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;187;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;10;0;6;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;183;0;55;0
WireConnection;8;0;3;0
WireConnection;54;0;183;0
WireConnection;54;1;53;0
WireConnection;56;0;54;0
WireConnection;38;0;37;0
WireConnection;38;1;36;0
WireConnection;33;0;14;0
WireConnection;33;1;34;0
WireConnection;33;2;34;0
WireConnection;203;1;33;0
WireConnection;204;1;33;0
WireConnection;74;0;73;0
WireConnection;74;1;76;1
WireConnection;57;0;56;0
WireConnection;39;0;38;0
WireConnection;207;1;33;0
WireConnection;25;1;33;0
WireConnection;205;1;33;0
WireConnection;206;1;33;0
WireConnection;58;0;57;0
WireConnection;58;1;59;0
WireConnection;185;0;184;0
WireConnection;91;0;74;0
WireConnection;91;1;92;0
WireConnection;209;1;25;0
WireConnection;209;0;203;0
WireConnection;209;2;204;0
WireConnection;209;3;205;0
WireConnection;209;4;206;0
WireConnection;209;5;207;0
WireConnection;98;0;96;0
WireConnection;98;1;97;0
WireConnection;98;2;99;0
WireConnection;175;0;168;0
WireConnection;175;1;169;0
WireConnection;42;0;209;0
WireConnection;42;1;41;0
WireConnection;80;0;91;0
WireConnection;80;1;81;0
WireConnection;141;0;58;0
WireConnection;141;1;142;0
WireConnection;141;2;185;0
WireConnection;70;0;67;0
WireConnection;70;1;69;0
WireConnection;119;0;118;1
WireConnection;119;1;117;0
WireConnection;120;0;119;0
WireConnection;101;0;93;0
WireConnection;101;1;98;0
WireConnection;82;0;80;0
WireConnection;82;1;83;0
WireConnection;82;2;189;0
WireConnection;177;0;175;0
WireConnection;177;1;176;0
WireConnection;177;2;172;0
WireConnection;177;3;174;0
WireConnection;178;0;173;0
WireConnection;178;1;170;0
WireConnection;178;2;171;0
WireConnection;68;0;141;0
WireConnection;68;1;70;0
WireConnection;28;0;42;0
WireConnection;130;0;128;0
WireConnection;130;1;129;0
WireConnection;130;2;127;0
WireConnection;179;0;178;0
WireConnection;179;1;177;0
WireConnection;132;0;131;0
WireConnection;132;1;130;0
WireConnection;94;0;82;0
WireConnection;94;1;101;0
WireConnection;122;0;36;4
WireConnection;71;0;68;0
WireConnection;85;0;94;0
WireConnection;85;1;86;0
WireConnection;66;0;71;0
WireConnection;66;1;132;0
WireConnection;126;0;108;0
WireConnection;126;1;107;0
WireConnection;109;0;104;0
WireConnection;181;0;180;0
WireConnection;181;1;179;0
WireConnection;182;0;181;0
WireConnection;123;0;111;0
WireConnection;123;1;124;0
WireConnection;60;0;66;0
WireConnection;110;0;105;0
WireConnection;110;1;106;0
WireConnection;110;2;109;0
WireConnection;87;0;88;0
WireConnection;87;1;85;0
WireConnection;112;0;107;0
WireConnection;112;1;126;0
WireConnection;113;0;112;0
WireConnection;113;2;123;0
WireConnection;113;1;110;0
WireConnection;89;0;87;0
WireConnection;72;0;32;0
WireConnection;72;1;62;0
WireConnection;114;0;113;0
WireConnection;121;0;118;3
WireConnection;121;1;118;2
WireConnection;121;2;118;1
WireConnection;121;3;118;4
WireConnection;95;0;72;0
WireConnection;95;1;90;0
WireConnection;0;13;95;0
WireConnection;0;11;115;0
ASEEND*/
//CHKSM=50618A911C609935DE9A92CA18029646844D4EB3