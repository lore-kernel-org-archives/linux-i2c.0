From: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH v2 1/1 resend] i2c: rcar: modify I2C driver
Date: Thu, 08 Aug 2013 10:13:16 +0900
Message-ID: <5202F0AC.4070609@jinso.co.jp>
References: <1375687174-577-1-git-send-email-nv-dung@jinso.co.jp> <1375687174-577-2-git-send-email-nv-dung@jinso.co.jp> <20130807151234.GH2978@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130807151234.GH2978@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Difference between H2 and H1 in hardware is only CDF bit of ICCCR register.
So, by using the flag variable in pdata, it is possible to distinguish 
H2 and H1.

If this method is not a common method, please tell me about common method.

Thanks,
Dung
On 08/08/2013 12:12 AM, Wolfram Sang wrote:
> On Mon, Aug 05, 2013 at 04:19:34PM +0900, Nguyen Viet Dung wrote:
>> This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.
>>
>> Signed-off-by: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
> Isn't it possible to distinguish between H1 and H2 somewhere in
> hardware? Then we could skip the 'flags' variable in pdata.
>
> Thanks,
>
>     Wolfram
