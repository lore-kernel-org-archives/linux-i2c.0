From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Tue, 18 Jun 2013 09:44:17 +0200
Message-ID: <CACRpkdakdUVzHM4L5qOJ5Ls8NwOimy197NCUDSP=X28d2fzHPg@mail.gmail.com>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
	<CACRpkdae1chj9ZKuQV5MuiaicLUTKr4hZqr8rtjbB3Yjt+U_fg@mail.gmail.com>
	<51BF2FC5.40207@wwwdotorg.org>
	<CACRpkdbjy+PcpNkSg4PuuP2Z9RyrnqSW0uchHFHVZ8VYPeoDyA@mail.gmail.com>
	<CACxGe6sTq=h9jjqesjvUA4Bweh7zgE4VOLoOTgGPC_D_v+8NtA@mail.gmail.com>
	<20130618073302.GA2962@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130618073302.GA2962@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 18, 2013 at 9:33 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Jun 17, 2013 at 11:15:30PM +0100, Grant Likely wrote:
>> On Mon, Jun 17, 2013 at 5:33 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > OK that works for me, I'm not in any hurry.
>>
>> Deferring by a merge window isn't going to make it any less painful.
>> Do your best to find all the users that need to be changed. Use a
>> coccinelle search perhaps, but I think it should be merged anyway.
>
> I'll try a bit of my coccinelle-foo today and then decide.

Thanks Wolfram, much appreciated.

Yours,
Linus Walleij
