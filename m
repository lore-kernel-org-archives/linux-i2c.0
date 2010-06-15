From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 8/8]tuners:tuner-simple Fix warning: variable 'tun' set
 but not used
Date: Mon, 14 Jun 2010 22:50:02 -0700
Message-ID: <4C17148A.508@gmail.com>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-9-git-send-email-justinmattock@gmail.com> <4C170CA4.2020805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4C170CA4.2020805@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, clemens@ladisch.de, debora@linux.vnet.ibm.com, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 06/14/2010 10:16 PM, Mauro Carvalho Chehab wrote:
>
>
> Em 14-06-2010 23:26, Justin P. Mattock escreveu:
>> not sure if this is correct or not for
>> fixing this warning:
>>    CC [M]  drivers/media/common/tuners/tuner-simple.o
>> drivers/media/common/tuners/tuner-simple.c: In function 'simple_set_tv_freq':
>> drivers/media/common/tuners/tuner-simple.c:548:20: warning: variable 'tun' set but not used
>>
>>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>
>> ---
>>   drivers/media/common/tuners/tuner-simple.c |    4 +---
>>   1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/common/tuners/tuner-simple.c b/drivers/media/common/tuners/tuner-simple.c
>> index 8abbcc5..4465b99 100644
>> --- a/drivers/media/common/tuners/tuner-simple.c
>> +++ b/drivers/media/common/tuners/tuner-simple.c
>> @@ -545,14 +545,12 @@ static int simple_set_tv_freq(struct dvb_frontend *fe,
>>   	struct tuner_simple_priv *priv = fe->tuner_priv;
>>   	u8 config, cb;
>>   	u16 div;
>> -	struct tunertype *tun;
>>   	u8 buffer[4];
>>   	int rc, IFPCoff, i;
>>   	enum param_type desired_type;
>>   	struct tuner_params *t_params;
>>
>> -	tun = priv->tun;
>> -
>> +	
> Why are you adding an extra blank line here? Except for that, the patch
> looks sane.
>
>>   	/* IFPCoff = Video Intermediate Frequency - Vif:
>>   		940  =16*58.75  NTSC/J (Japan)
>>   		732  =16*45.75  M/N STD
>
>

o.k. resent this.. I ended up doing
a git reset do make sure things dont get
funky etc..

Justin P. Mattock
