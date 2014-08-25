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
	if(param==0.)
	{
		gl_FragColor=texelFetch(texture,ivec2(gl_FragCoord.xy),0);
		return;
	}
	float r=pow(1.-param,4.)*max(size.x,size.y)+1.;
	r=max(size.x,size.y)/int(r);
	ivec2 p=ivec2(gl_FragCoord.xy-mod(gl_FragCoord.xy,r)+r/2);
	gl_FragColor=texelFetch(texture,ivec2(clamp(p,ivec2(0),size-1)),0);
}