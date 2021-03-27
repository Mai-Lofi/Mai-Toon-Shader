// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "!OdinShader!"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_TextureSample7("Texture Sample 7", 2D) = "white" {}
		_Primarycolor("Primary color", Color) = (0.4056604,0.4056604,0.4056604,0)
		_Secondarycolor("Secondary color", Color) = (0.9716981,0.9595354,0.5821022,0)
		_Terciarycolor("Terciary color", Color) = (0.9992574,1,0.6839622,0)
		_Accentcolor("Accent color", Color) = (0.1462264,0.9065037,1,0)
		_Roughness("Roughness", Float) = 0
		_Float0222("Float 0222", Float) = 0
		_Float1("Float 1", Float) = 0
		_Float2("Float 2", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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

		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float4 _Accentcolor;
		uniform float4 _Primarycolor;
		uniform float4 _Secondarycolor;
		uniform float4 _Terciarycolor;
		uniform sampler2D _TextureSample7;
		uniform float4 _TextureSample7_ST;
		uniform float _Float2;
		uniform float _Roughness;
		uniform float _Float0222;
		uniform float _Float1;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s136_g90 = (SurfaceOutputStandard ) 0;
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode19_g91 = tex2D( _Texture0, uv_Texture0 );
			float4 Accentcolor57_g90 = _Accentcolor;
			float4 Primarycolor54_g90 = _Primarycolor;
			float4 Secondarycolor55_g90 = _Secondarycolor;
			float4 TerciaryColor56_g90 = _Terciarycolor;
			float4 MaiDIffuseOut75_g90 = ( ( tex2DNode19_g91.a * Accentcolor57_g90 ) + ( tex2DNode19_g91.r * Primarycolor54_g90 ) + ( tex2DNode19_g91.g * Secondarycolor55_g90 ) + ( tex2DNode19_g91.b * TerciaryColor56_g90 ) );
			s136_g90.Albedo = MaiDIffuseOut75_g90.rgb;
			float2 uv_TextureSample7 = i.uv_texcoord * _TextureSample7_ST.xy + _TextureSample7_ST.zw;
			s136_g90.Normal = WorldNormalVector( i , ( tex2D( _TextureSample7, uv_TextureSample7 ) * 23.23 ).rgb );
			s136_g90.Emission = float3( 0,0,0 );
			s136_g90.Metallic = 0.0;
			float4 tex2DNode19_g93 = tex2D( _Texture0, uv_Texture0 );
			float AccentRoughness64_g90 = _Float2;
			float4 temp_cast_2 = (AccentRoughness64_g90).xxxx;
			float PrimaryRoughness61_g90 = _Roughness;
			float4 temp_cast_3 = (PrimaryRoughness61_g90).xxxx;
			float SecondaryRoughness62_g90 = _Float0222;
			float4 temp_cast_4 = (SecondaryRoughness62_g90).xxxx;
			float TerciaryRoughness63_g90 = _Float1;
			float4 temp_cast_5 = (TerciaryRoughness63_g90).xxxx;
			float4 mairoughness156_g90 = ( ( tex2DNode19_g93.a * temp_cast_2 ) + ( tex2DNode19_g93.r * temp_cast_3 ) + ( tex2DNode19_g93.g * temp_cast_4 ) + ( tex2DNode19_g93.b * temp_cast_5 ) );
			s136_g90.Smoothness = mairoughness156_g90.r;
			s136_g90.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi136_g90 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g136_g90 = UnityGlossyEnvironmentSetup( s136_g90.Smoothness, data.worldViewDir, s136_g90.Normal, float3(0,0,0));
			gi136_g90 = UnityGlobalIllumination( data, s136_g90.Occlusion, s136_g90.Normal, g136_g90 );
			#endif

			float3 surfResult136_g90 = LightingStandard ( s136_g90, viewDir, gi136_g90 ).rgb;
			surfResult136_g90 += s136_g90.Emission;

			#ifdef UNITY_PASS_FORWARDADD//136_g90
			surfResult136_g90 -= s136_g90.Emission;
			#endif//136_g90
			c.rgb = surfResult136_g90;
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

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
862;493.5;933;304;-359.7291;369.1821;1.787298;True;False
Node;AmplifyShaderEditor.ColorNode;40;1234.126,-146.4907;Inherit;False;Property;_Primarycolor;Primary color;22;0;Create;True;0;0;0;False;0;False;0.4056604,0.4056604,0.4056604,0;0.08490568,0.08490568,0.08490568,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;41;1219.825,19.90918;Inherit;False;Property;_Secondarycolor;Secondary color;23;0;Create;True;0;0;0;False;0;False;0.9716981,0.9595354,0.5821022,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;42;1218.525,185.0093;Inherit;False;Property;_Terciarycolor;Terciary color;24;0;Create;True;0;0;0;False;0;False;0.9992574,1,0.6839622,0;0.9992574,1,0.6839622,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;43;1210.726,346.2087;Inherit;False;Property;_Accentcolor;Accent color;25;0;Create;True;0;0;0;False;0;False;0.1462264,0.9065037,1,0;0.3301886,0.3301886,0.3301886,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;19;2349.596,330.0463;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;0;False;0;False;982175539796dcc4597291d5c2d73751;982175539796dcc4597291d5c2d73751;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;59;1872.49,924.0487;Inherit;False;Property;_Roughness;Roughness;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;1879.49,1067.049;Inherit;False;Property;_Float1;Float 1;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;1883.49,1144.049;Inherit;False;Property;_Float2;Float 2;30;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;1876.49,995.0487;Inherit;False;Property;_Float0222;Float 0222;28;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;68;2070.153,349.7823;Inherit;False;Property;_Alpha;Alpha;32;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;69;2076.288,182.0899;Inherit;False;Property;_RGB;RGB;31;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;1196.427,517.8096;Inherit;False;Property;_Fillcolor;Fill color;26;0;Create;True;0;0;0;False;0;False;0.3584906,0.3584906,0.3584906,0;0.6415094,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;63;1883.49,1211.049;Inherit;False;Property;_Float3;Float 3;33;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;72;2204.439,579.1955;Inherit;False;Mai WireframeGen!;1;;90;3777be207e3b80c4ba51feccc86e5e6d;0;31;36;COLOR;0,0,0,0;False;1;SAMPLER2D;0,0,0,0;False;21;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;5;SAMPLER2D;0;False;6;SAMPLER2D;0;False;7;SAMPLER2D;0;False;8;COLOR;0,0,0,0;False;9;SAMPLER2D;0;False;22;COLOR;0,0,0,0;False;10;SAMPLER2D;0;False;12;SAMPLER2D;0,0,0,0;False;13;SAMPLER1D;0,0,0,0;False;14;SAMPLER2D;0,0,0,0;False;15;SAMPLER2D;0,0,0,0;False;16;COLOR;0,0,0,0;False;17;COLOR;0,0,0,0;False;18;COLOR;0,0,0,0;False;19;COLOR;0,0,0,0;False;20;COLOR;0,0,0,0;False;11;SAMPLER2D;0;False;23;FLOAT;0;False;26;FLOAT;0;False;27;FLOAT;0;False;28;FLOAT;0;False;29;FLOAT;0;False;30;FLOAT;0;False;31;FLOAT;0;False;32;FLOAT;0;False;33;FLOAT;0;False;34;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;7;2727.833,339.9688;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;!OdinShader!;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;72;36;69;0
WireConnection;72;1;19;0
WireConnection;72;3;68;0
WireConnection;72;16;40;0
WireConnection;72;17;41;0
WireConnection;72;18;42;0
WireConnection;72;19;43;0
WireConnection;72;23;59;0
WireConnection;72;26;60;0
WireConnection;72;27;61;0
WireConnection;72;28;62;0
WireConnection;7;13;72;0
ASEEND*/
//CHKSM=A128BFFA7B3E9691BF1BCF7F5BA717B11D7C84C1