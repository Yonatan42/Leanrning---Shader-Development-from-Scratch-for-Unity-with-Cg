Shader "Course/P04/Hollistic/Rim" {

    Properties {
        _RimColor ("Rim Color", Color) = (0,0.5,0.5,0)
        _RimPower ("Rim Power", Range(0.5, 8)) = 1
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float3 viewDir;
            };

            float4 _RimColor;
            half _RimPower;

            void surf (Input IN, inout SurfaceOutput o){
                // normalize - takes the vector and shifts it so that its magnitude is 1
                // saturate makes the value between 0 and 1
                // the 1 - ...  is so that the bright part is on the outside and not the inside
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                // pow - power function
                o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            }

        ENDCG
    }

    Fallback "Diffuse"
}