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
	ivec2 g=ivec2(vec2(param)*size);
	vec4 namax=texelFetch(texture,ivec2(gl_FragCoord.xy)-ivec2(g.x,0),0)-texelFetch(texture,ivec2(gl_FragCoord.xy)+ivec2(g.x,0),0);
	vec4 namay=texelFetch(texture,ivec2(gl_FragCoord.xy)-ivec2(0,g.y),0)-texelFetch(texture,ivec2(gl_FragCoord.xy)+ivec2(0,g.y),0);
	vec4 col=abs(namax)+abs(namay);
	gl_FragColor=col;
}