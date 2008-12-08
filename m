From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Mon, 08 Dec 2008 11:18:59 +0200
Message-ID: <ghiopt$ce3$1@ger.gmane.org>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange> <20081203234317.GA4256@fluff.org.uk> <4937AA1C.8050004@gmail.com> <Pine.LNX.4.64.0812051612500.5840@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0812051612500.5840-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Thu, 4 Dec 2008, Darius wrote:
> 
>> I tested on MX1. There delay is not needed at all.
> 
> Darius, how exactly you tested on MX1? I just found out, that also 
> i2c_smbus_{read,write}_word_data() doesn't work with imx driver on i.MX31, 
> whereas the mxc driver does.

Hi Guennadi,

I tested with OV7720, OV7670 and MT9V111 drivers. Last one uses smbus data transfers - all works 100% ok.
Today I will post new patch version with most of your and Ben comments fixed.

Darius.

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
