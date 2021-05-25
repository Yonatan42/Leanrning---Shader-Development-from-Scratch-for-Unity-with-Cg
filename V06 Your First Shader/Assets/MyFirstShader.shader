Shader "Hollistic/HelloShader" {

    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
        _myEmission ("Example Emission", Color) = (1,1,1,1)
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float2 uvMainTex;
            };

            fixed4 _myColor;
            fixed4 _myEmission;

            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = _myColor.rgb; // the base color
                o.Emission = _myEmission.rgb; // the glow color
            }

        ENDCG
    }

    Fallback "Diffuse"
}