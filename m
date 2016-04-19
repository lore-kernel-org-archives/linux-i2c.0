From: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH v1 1/1] add missing UARTs pins for AllWinner
 H3 DTS + add new I2C entries for AllWinner H3 DTS
Date: Tue, 19 Apr 2016 11:27:16 -0700 (PDT)
Message-ID: <16057207-027e-4709-b5c2-61be199e5cb5@googlegroups.com>
References: <8673D89D449742EAB9F6EBD05655A295@GirolesWin7> <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
 <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab@googlegroups.com>
 <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q@mail.gmail.com>
Reply-To: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_61_2113918111.1461090436457"
Return-path: <linux-sunxi+bncBDW4XUV4YULRBBHR3G4AKGQEKEFASZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65dsjbpGUrJXFG35cLGnFA6uDxtgMqupBN97=8XNnO68Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

------=_Part_61_2113918111.1461090436457
Content-Type: text/plain; charset=UTF-8

On Tuesday, April 19, 2016 at 11:11:37 AM UTC-4, Chen-Yu Tsai wrote:
> Try to wrap lines to 80 characters or less.

Ok ! I will be more careful ...

> 1 change per patch. You are making 3 changes here. a) adding shared
> pinmux settings,
> b & c) enabling uarts and i2c busses for 2 boards.
> 
> You could split them into 1 dtsi patch adding the pinmux setting, and
> then 1 for each
> board enabling the peripherals.

Fine ! I will prepare and redo a new submit with only the DTSI for now.

> Perhaps they were enabled before the policy was enacted, or it just
> slipped through. I
> contributed to a few. But for many boards we might not have schematics
> or the actual
> device to check.

Understood ! But sometimes things are so generic, like having uart0 and not having uart1 make it looks a bit strange. Some other times having some i2c2 because of PMIC while not having i2c0 and i2c1 is also strange.

> How would you determine what the most common usage is for "development boards"?
> If the vendor explicitly designed the pins to be used one way, and even printed
> the description on the board, then you may have a valid argument. But even then,
> with the C.H.I.P., they are going with DT overlays.
> 
> It shouldn't be hard for an end user to modify the DT. And with I2C devices, it
> is almost a requirement.

Ok ! I will look if it is easier to do the rest with overlays.
------=_Part_61_2113918111.1461090436457--
