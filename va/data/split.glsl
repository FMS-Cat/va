/*
.set("size",width,height);
.set("time",frameCount);
.set("param",split);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

void main()
{
	ivec2 p=ivec2(mod(gl_FragCoord.xy*floor(1+vec2(param)*16),size));
	vec4 col=texelFetch(texture,p,0);
	gl_FragColor=col;
}