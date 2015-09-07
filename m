From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [PATCH 0/8] i2c: img-scb: fixes to support i2c on pistachio
Date: Mon, 7 Sep 2015 11:22:23 -0300
Message-ID: <CAAEAJfBj+qdv58gzOnqMrmN0486Enzbn3G1L0KhMctMkEkXfTw@mail.gmail.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
	<20150731111252.GL1522@katana>
	<CAAEAJfCW9cEMDZwta5Q6VVEZfzxTDZ50Fx=YeW6bPMnrtKNcbw@mail.gmail.com>
	<20150907135037.GA4986@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150907135037.GA4986@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 7 September 2015 at 10:50, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> > That sounds like good testing \o/ If you are happy with i2ctransfe=
r,
>> > then please consider adding Tested-by tags to the i2ctransfer patc=
hes,
>> > so Jean gets a more cosy feeling to include them to i2ctools.
>> >
>>
>> Definitely! i2ctransfer was a HUGE help while developing this driver=
,
>> specially when preparing involved transfers to test repeated starts.
>
> Glad to hear that! I also discovered and fixed a corner case in repea=
ted
> start handling recently in the i2c-rcar driver thanks to i2ctransfer.
>
>> Any chance it gets merged in its current state? I think it'll be use=
ful, even
>> if the usage cli API is still a moving target.
>
> I don't think it is anymore TBH. Not more than any other tool.
>
> Waiving to Jean \o_ :)
>

OK, let me wave as well \\O//

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
