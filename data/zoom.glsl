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
	gl_FragColor=texelFetch(texture,ivec2((gl_FragCoord.xy-size/2)/(1+param*3)+size/2),0);
}