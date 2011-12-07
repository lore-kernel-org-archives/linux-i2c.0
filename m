From: "Pierre-Yves Rofes" <py.rofes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c-ali1535: enable SPARC support
Date: Wed, 7 Dec 2011 09:04:56 +0100
Message-ID: <f4dd6eb0ec3cf5cb9c0ce90d6b06d08c.squirrel@mail.rofes.fr>
References: <20111125142351.739f6b89@endymion.delvare>
    <4ED36E2F.3010003@geomatys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ED36E2F.3010003-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "corentin.labbe" <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, November 28, 2011 12:19 pm, corentin.labbe wrote:
> Le 25/11/2011 14:23, Jean Delvare a =E9crit :
>> From: "corentin.labbe" <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
>>
>> The i2c-ali1535 driver don't work on SPARC, this is because it assum=
es that
>> ioport address are 16bits wide (address stored with an unsigned shor=
t).
>> But on SPARC arch, ioports are mapped in memory and so are stored wi=
th an
>> unsigned long.
>>
>> This patch corrects this by using pci_resource_start for getting IOM=
EM base
>> address, then reading the SMBBA of the i2c busse and using together =
for I/O
>> access.
>>
>> I like to thanks Jean DELVARE for reviewing of my patch.
>>
>> Signed-off-by: LABBE Corentin <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
>> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> ---
>> Corentin, I rebased your patch so that it applies on top of the fix =
I
>> just sent. I also turned one dev_info into dev_dbg, and relaxed the
>> check on the PCI resource flags: I have no idea if the resource is
>> always defined, in particular on x86, and as it will be difficult to
>> find testers, I want to play it safe and guarantee that the driver w=
ill
>> behave the same way it used to before your patch.
>>
>> Corentin, Pierre-Yves, please test this version of the patch on top =
of
>> the fix I just sent, and confirm that it works for you.
>
> It works for me.
>
> Thanks for your work.
>

Works for me too, thanks!

--=20
Pierre-Yves Rofes
