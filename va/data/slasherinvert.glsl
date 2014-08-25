/*
.set("size",width,height);
.set("time",frameCount);
.set("param",weight);
*/

uniform sampler2D texture;
uniform ivec2 size;
uniform int time;
uniform float param;

void main()
{
	float s=max(size.x,size.y)*sqrt(2)/48.;
	vec3 col;
	vec3 tex=texelFetch(texture,ivec2(gl_FragCoord.xy),0).xyz;
	if(mod(gl_FragCoord.x-gl_FragCoord.y,s)<(param*1.2-.1)*s)
	{
		col=(1-tex);
	}else{
		col=tex;
	}
	gl_FragColor=vec4(vec3(col),1);
}