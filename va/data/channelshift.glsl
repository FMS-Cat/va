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
	ivec2 rp=ivec2(gl_FragCoord.xy+vec2(param,0)*size);
	ivec2 gp=ivec2(gl_FragCoord.xy);
	ivec2 bp=ivec2(gl_FragCoord.xy-vec2(param,0)*size);
	rp=ivec2(clamp(rp.x,1,size.x-1),rp.y);
	bp=ivec2(clamp(bp.x,1,size.x-1),bp.y);
	float r=texelFetch(texture,rp,0).r;
	float g=texelFetch(texture,gp,0).g;
	float b=texelFetch(texture,bp,0).b;
	gl_FragColor=vec4(r,g,b,1);
}