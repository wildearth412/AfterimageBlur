Shader "Custom/AfterimageBlur"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		//_Color("Color", color) = (0.18823, 0.18823, 0.18823, 0)
		_Transparent("Transparent Blend", Float) = 1.0
	}
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			Name "Update"

			CGPROGRAM
			#pragma vertex CustomRenderTextureVertexShader
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "UnityCustomRenderTexture.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			//fixed4 _Color;
			float _Transparent;
			
			fixed4 frag (v2f_customrendertexture i) : SV_Target
			{
				float2 uv = i.globalTexcoord;
				float4 colPre = tex2D(_SelfTexture2D, uv);
				float4 colCur = tex2D(_MainTex, uv);
				float4 col;
				col = colPre * _Transparent + colCur;

				return col;
			}
			ENDCG
		}
	}
}
