/*
.set("size",width,height);
.set("time",frameCount);
.set("param",amount);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

void main()
{
	vec2 v=vec2(gl_FragCoord.xy-size/2);
	float d=length(v);
	gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.xy-normalize(v)*param*min(size.x,size.y)*.5),0);
}