From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Thu, 28 May 2009 13:31:20 -0600
Message-ID: <fa686aa40905281231o26c74a13v250bcedbd066e77b@mail.gmail.com>
References: <4A124202.4010201@doredevelopment.dk> <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d2b9ea600905260430i72290901p9266de4cade049c1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 26, 2009 at 5:30 AM, Esben Haabendal
<esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment=
=2Edk> wrote:
>> This fixes MAL (arbitration lost) bug caused by illegal use of
>> RSTA (repeated START) after STOP condition generated after last byte
>> of reads. With this patch, it is possible to do an i2c_transfer() wi=
th
>> additional i2c_msg's following the I2C_M_RD messages.
>>
>> It still needs to be resolved if it is possible to fix this issue
>> by removing the STOP condition after reads in a robust way.
>>
>> Signed-off-by: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A09 +++++++--
>> =A01 files changed, 7 insertions(+), 2 deletions(-)
>
> Any blockers to get this accepted?

It helps if you cc: developers/maintainers of the device.  ie. Kumar
for mpc8xxx, me for 52xx.

This is the first time I noticed your posting.  It will take me a few
days before I get a chance to review it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
