Shader "Course/P04/Hollistic/Cutoff" {

    Properties {
        _RimColor ("Rim Color", Color) = (0,0.5,0.5,0)
        _StripeWidth ("Stripe Width", Range(1, 100)) = 10
    }

    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float3 viewDir;
                float3 worldPos; // the position in the world (meaning that this changes if the object is moved)
            };

            float4 _RimColor;
            half _StripeWidth;

            void surf (Input IN, inout SurfaceOutput o){
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                // frac - the remainder a number
                // * _StripeWidth - modify the width of the stripes by multiplying but a given value
                // * 0.5 - basically switches off - even / odd (along with the next line)
                // > 0.5 divide the options into two equal parts
                o.Emission = frac(IN.worldPos.y * _StripeWidth * 0.5) > 0.5 ?
                    float3(0,1,0) * rim : // green
                    float3(1,0,0) * rim; // red
            }

        ENDCG
    }

    Fallback "Diffuse"
}