Shader "Course/P05/Hollistic/BasicLambert" {

    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor ("Specular Color", Color) = (1,1,1,1)
        _Spec ("Specular", Range(0,1)) = 0.5 // specular power
        _Gloss ("Gloss", Range(0,1)) = 0.5 // specular intensity
    }

    SubShader {

        Tags {
            "Queue" = "Geometry"
        }

        CGPROGRAM
            #pragma surface surf Lambert

            float4 _Color;
            // float4 _SpecColor; // !!!! note that we don't need to define this one because unity already defines it for us (if we try to redefine it we will actually get an error)
            half _Spec;
            fixed _Gloss; 

            struct Input {
                float2 uv_MainTex;
            };

            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = _Color.rgb;

                // note that these don't work with Lambert as it doesn't have specular lighting
                o.Specular = _Spec;
                o.Gloss = _Gloss;
            }

        ENDCG
    }

    Fallback "Diffuse"
}