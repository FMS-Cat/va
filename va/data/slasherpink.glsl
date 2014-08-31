/*
.set("size",width,height);
.set("time",frameCount);
.set("param",weight);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

#define PI 3.1415926

vec3 hue()
{
	float i=mod(5.6,6.);
	float r=clamp(abs(3-i)-1,0,1);
	float g=clamp(2-abs(2-i),0,1);
	float b=clamp(2-abs(4-i),0,1);
	return vec3(r,g,b);
}

void main()
{
	float s=32;
	vec3 col;
	vec3 tex=texelFetch(texture,ivec2(gl_FragCoord.xy),0).xyz;
	float g=(tex.r+tex.g+tex.b)/3;
	float i=clamp((param*1.2-.1)*s-mod(gl_FragCoord.x-gl_FragCoord.y,s),0.,1.);
	col=(1-g)*hue()*i+tex*(1-i);
	gl_FragColor=vec4(vec3(col),1);
}