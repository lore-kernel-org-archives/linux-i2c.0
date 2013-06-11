From: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4 - Add support for secondary SMBus on AMD SB800
 and AMD FCH chipsets
Date: Tue, 11 Jun 2013 21:47:12 +0200
Message-ID: <51B77EC0.2020204@assembler.cz>
References: <5196B32D.7060501@assembler.cz> <1369294522.12648.11.camel@mattotaupa> <20130611193539.GG3376@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130611193539.GG3376@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> Do you know if there should be something connected?

In Paul case, most likely not. In my case there is a voltage controller for the 
DDR3 voltage regulator. I asked Paul test it on his SB800 system, I have the 
Hudson successor..

>> Rudolf, it looks like your patch could also update the i2c files under
>> `Documentation`. At least there are some patches doing that.
>
> Do you mean 'busses/i2c-piix4'?

Yes he means that. I will add documentation to the patch.

Thanks
Rudolf
