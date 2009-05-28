From: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Thu, 28 May 2009 22:15:22 +0200
Message-ID: <d2b9ea600905281315x435cdb05ia7b016b3d60c4a65@mail.gmail.com>
References: <4A124202.4010201@doredevelopment.dk>
	 <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	 <fa686aa40905281231o26c74a13v250bcedbd066e77b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa40905281231o26c74a13v250bcedbd066e77b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-JorI+TVEvZrY24RiXHRV3ti2O/JbrIOy@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 28, 2009 at 9:31 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> On Tue, May 26, 2009 at 5:30 AM, Esben Haabendal wrote:
>> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal wrote:
>>> This fixes MAL (arbitration lost) bug caused by illegal use of
>>> RSTA (repeated START) after STOP condition generated after last byt=
e
>>> of reads. With this patch, it is possible to do an i2c_transfer() w=
ith
>>> additional i2c_msg's following the I2C_M_RD messages.
>>>
>>> It still needs to be resolved if it is possible to fix this issue
>>> by removing the STOP condition after reads in a robust way.
>>>
>>> Signed-off-by: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
>>> ---
>>> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A09 +++++++--
>>> =A01 files changed, 7 insertions(+), 2 deletions(-)
>>
>> Any blockers to get this accepted?
>
> It helps if you cc: developers/maintainers of the device. =A0ie. Kuma=
r
> for mpc8xxx, me for 52xx.
>
> This is the first time I noticed your posting. =A0It will take me a f=
ew
> days before I get a chance to review it.

Kumar, will you take a look at this patch?

/Esben
