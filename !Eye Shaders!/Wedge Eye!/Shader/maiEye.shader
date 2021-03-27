//Made by Mai Lofi
Shader "!Mai Lofi!/Eye/Mai Wedge Shader"
{
	Properties
	{
		_NoiseMap("Noise Map", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_NoiseMapStrength("NoiseMapStrength", Range( 0 , 1)) = 0.191
		_RingPanner("RingPanner", Range( 0 , 1)) = 0
		_emiss("emiss", Range( 0 , 4)) = 2.03
		_RingPannerSpeed("RingPannerSpeed", Vector) = (1,0,0,0)
		_NoiseMapSize("NoiseMapSize", Vector) = (1,1,0,0)
		_NoiseMapPannerSpeed("NoiseMapPannerSpeed", Vector) = (0.2,0.2,0,0)
		_BaseTexture("Base Texture", 2D) = "white" {}
		_Tint("Tint", Color) = (0.9803922,0.6509804,0.8196079,0)
		[Toggle]_EyeType2("Eye Type 2", Float) = 0
		[Toggle]_EyeType3("Eye Type 3", Float) = 0
		[Toggle]_EyeType1("Eye Type 1", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Tint;
		uniform sampler2D _BaseTexture;
		uniform float _EyeType2;
		uniform sampler2D _NoiseMap;
		uniform float2 _NoiseMapSize;
		uniform float2 _NoiseMapPannerSpeed;
		uniform float _NoiseMapStrength;
		uniform float2 _RingPannerSpeed;
		uniform float _RingPanner;
		uniform float _EyeType1;
		uniform sampler2D _Texture1;
		uniform float _EyeType3;
		uniform sampler2D _Texture0;
		uniform float _emiss;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_1_0_g50 = _NoiseMapSize;
			float2 appendResult10_g50 = (float2(( (temp_output_1_0_g50).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g50).y )));
			float2 temp_output_11_0_g50 = _NoiseMapPannerSpeed;
			float2 panner18_g50 = ( ( (temp_output_11_0_g50).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g50 = ( ( _Time.y * (temp_output_11_0_g50).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g50 = (float2((panner18_g50).x , (panner19_g50).y));
			float2 _Vector0 = float2(1,1);
			float4 appendResult408 = (float4(( _RingPannerSpeed.x * _RingPanner ) , _RingPannerSpeed.y , 0.0 , 0.0));
			float2 temp_output_47_0_g50 = appendResult408.xy;
			float2 uv_TexCoord78_g50 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g50 = ( uv_TexCoord78_g50 - float2( 1,1 ) );
			float2 appendResult39_g50 = (float2(frac( ( atan2( (temp_output_31_0_g50).x , (temp_output_31_0_g50).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g50 )));
			float2 panner54_g50 = ( ( (temp_output_47_0_g50).x * _Time.y ) * float2( 1,0 ) + appendResult39_g50);
			float2 panner55_g50 = ( ( _Time.y * (temp_output_47_0_g50).y ) * float2( 0,1 ) + appendResult39_g50);
			float2 appendResult58_g50 = (float2((panner54_g50).x , (panner55_g50).y));
			float2 temp_output_1_0_g52 = _NoiseMapSize;
			float2 appendResult10_g52 = (float2(( (temp_output_1_0_g52).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g52).y )));
			float2 temp_output_11_0_g52 = _NoiseMapPannerSpeed;
			float2 panner18_g52 = ( ( (temp_output_11_0_g52).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g52 = ( ( _Time.y * (temp_output_11_0_g52).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g52 = (float2((panner18_g52).x , (panner19_g52).y));
			float2 temp_output_47_0_g52 = appendResult408.xy;
			float2 uv_TexCoord78_g52 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g52 = ( uv_TexCoord78_g52 - float2( 1,1 ) );
			float2 appendResult39_g52 = (float2(frac( ( atan2( (temp_output_31_0_g52).x , (temp_output_31_0_g52).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g52 )));
			float2 panner54_g52 = ( ( (temp_output_47_0_g52).x * _Time.y ) * float2( 1,0 ) + appendResult39_g52);
			float2 panner55_g52 = ( ( _Time.y * (temp_output_47_0_g52).y ) * float2( 0,1 ) + appendResult39_g52);
			float2 appendResult58_g52 = (float2((panner54_g52).x , (panner55_g52).y));
			float2 temp_output_1_0_g51 = _NoiseMapSize;
			float2 appendResult10_g51 = (float2(( (temp_output_1_0_g51).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g51).y )));
			float2 temp_output_11_0_g51 = _NoiseMapPannerSpeed;
			float2 panner18_g51 = ( ( (temp_output_11_0_g51).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g51 = ( ( _Time.y * (temp_output_11_0_g51).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g51 = (float2((panner18_g51).x , (panner19_g51).y));
			float2 temp_output_47_0_g51 = appendResult408.xy;
			float2 uv_TexCoord78_g51 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g51 = ( uv_TexCoord78_g51 - float2( 1,1 ) );
			float2 appendResult39_g51 = (float2(frac( ( atan2( (temp_output_31_0_g51).x , (temp_output_31_0_g51).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g51 )));
			float2 panner54_g51 = ( ( (temp_output_47_0_g51).x * _Time.y ) * float2( 1,0 ) + appendResult39_g51);
			float2 panner55_g51 = ( ( _Time.y * (temp_output_47_0_g51).y ) * float2( 0,1 ) + appendResult39_g51);
			float2 appendResult58_g51 = (float2((panner54_g51).x , (panner55_g51).y));
			o.Emission = ( _Tint * tex2D( _BaseTexture, ( (( _EyeType2 )?( ( ( (tex2D( _NoiseMap, ( appendResult10_g50 + appendResult24_g50 ) )).rg * _NoiseMapStrength ) + ( _Vector0 * appendResult58_g50 ) ) ):( float2( 0,0 ) )) + (( _EyeType1 )?( ( ( (tex2D( _Texture1, ( appendResult10_g52 + appendResult24_g52 ) )).rg * _NoiseMapStrength ) + ( _Vector0 * appendResult58_g52 ) ) ):( float2( 0,0 ) )) + (( _EyeType3 )?( ( ( (tex2D( _Texture0, ( appendResult10_g51 + appendResult24_g51 ) )).rg * _NoiseMapStrength ) + ( _Vector0 * appendResult58_g51 ) ) ):( float2( 0,0 ) )) ) ) * _emiss ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "MaiWedgeGUI"
}
