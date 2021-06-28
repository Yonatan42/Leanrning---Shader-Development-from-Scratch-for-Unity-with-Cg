Shader "Course/P02/Hollistic/PackedPractice" {

    Properties {
        _myColor ("Example Color", Color) = (1,1,1,1)
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float2 uvMainTex;
            };

            fixed4 _myColor;

            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = _myColor.rgb;
            }

        ENDCG
    }

    Fallback "Diffuse"
}