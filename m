Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581948;
	b=44l7JsHsIg8BmqydOrG5ZuUyx10zeUfOOXhs6PDqjeDQpt/inzIM4EkCzs2OTUKE7jEx
	 pEb4CF1Zh324nTm677FiE0//yulh9IoqNWZwWNi/l2Ng6iYc4BIn+WXWjRbobtavE1X78
	 ZhpXWn509ss2g/jza41aOkt/ypc0hf4AFyqzUlVYXS78eE30oJGgl0wPu+/3OylI8S+YQ
	 dnanydm9jsrIVa1LcOCIjjcjxhsvcM02wN2auWTvjsvhenuOHVAyPpbwPFUdtmPXcD376
	 PZKyF3u4sm4lAYqkUaRjPJNQ/VJF2gVtuvPX41J7tgRGSQzbGo6/Z7ZaNAnbHRy0JEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581948;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vcAdNlTJUdSpGYZ7jzE4GyHvPM4kjmmsapT2Zm9/2OA=;
	b=sIDfyYkLp4ru0jS79gmLAVJIgGdhK6CBcdRZL8m9ZKmvq98ZuXjLTBj74JN24aMGGaQC
	 HHw33aSp7f7c09mHLkl29WR31y1n/X1BgUed9OLd78xUn5FNSrthKbVlOL9/d4TKpb1Fm
	 lk99nPaq/M6TbNp4qOdKoLDauJGtLv8ECmI/98gzxXTO9bQs/i3vF9FxjDwrEk1uF1JR+
	 tz6P67ywk0AfxLvv9pd81+vMjX0YHCY4iRht5th1toj9AT9HjXOXfVdubLOL0WozgcLh6
	 o/pUewM85DmZZeTBRs8ep8UXtPbTpLwHj9khu+W0Jv3czKSHh6miVr95yzCD7qwqnzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=hv8p6RY3;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88510606A327
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 14:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88510606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=hv8p6RY3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794581941; x=1794841141;
	bh=vcAdNlTJUdSpGYZ7jzE4GyHvPM4kjmmsapT2Zm9/2OA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hv8p6RY3dGP3ydGWt0DfS+yIvl2Gi17TeS3xjiUr7ke9DrzsQilEbMUP6f4YjebNJ
	 DSiUxn6K8h1542MJrPk3u8JRCWVKhgrS/FQ5nIs98aoNaDeyqCDyo72mtKRblQOq88
	 C7eL73fUqkyvpCxx4UDUGNTFvHxM6+u4fclZrdjQyqpoaB5kR+UAk1/oWesZ8LIpAK
	 N+xuE02k4UScXMKaOS3PhB+FZl2T0c+p+Jv/0WAX+e2iLC1aZLzWcJg03Es0O4CymB
	 j+RSzq36JIbQa1pFAPEnB9oY7QUuZ+iVhTW74pc1OvV4tZvbMDv92QaXJyDmhy79ec
	 vs5q3aosE2Scg==
Date: Fri, 13 Nov 2026 14:58:54 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: penhouse24@proton.me
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <qes2otLcWzK-A7GjSQlLT1Cv6MA7huch5ONx4zWop9mKatqEJnnEkJ9x_qc-GVj4QGLE2pc9KE4cCAZbVriwD9lWR00ykER6KRhOi1HbAyE=@proton.me>
In-Reply-To: <avcizZOPWqA3r_qA@ashevche-desk.local>
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com> <avcBBe428-3Fdonb@ashevche-desk.local> <oyP4Jwe9KmZeViSughKaFgfxdsCa4bOmWguiI5_JlkvEHQ3lSwRAgU48s260tgGXfueLHta38-Zlhq9LQ-oB4aEObhQdAH7mujrH4BFSQ90=@proton.me> <avcizZOPWqA3r_qA@ashevche-desk.local>
Feedback-ID: 217801480:user:proton
X-Pm-Message-ID: 3ff6b8e5962364907288bac0a8022a106e726a9b
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,=20

Done.=20



On Friday, November 13th, 2026 at 9:46 AM, Andy Shevchenko <andriy.shevchen=
ko@linux.intel.com> wrote:

> On Fri, Nov 13, 2026 at 02:17:23PM +0000, penhouse24@proton.me wrote:
> > Hi Andy,
> >
> > Yes this post explains this exact problem (I even posted on it).
> >
> > Since applying the 100khz patch I have had 0 issue with the touchpad. N=
ot
> > sure why the Dell XPS 17 9720 is so unique in this issue, but amongst a=
ll the
> > firmware updates I have received since purchasing this computer, there =
has
> > been 0 improvement to this.
> >
> > I appreciate you all working to resolve this issue. Is there any furthe=
r
> > information I can provide you all to get a fix pushed to the main Linux
> > kernel?
>=20
> Can you comment on that bug with a link to this thread that your case is =
fixed
> by this patch, so others also may test it?
>=20
> > On Friday, November 13th, 2026 at 7:22 AM, Andy Shevchenko <andriy.shev=
chenko@linux.intel.com> wrote:
> > > On Fri, Nov 13, 2026 at 09:39:40AM +0100, Mika Westerberg wrote:
> > > > The Dell XPS 17 9720 touchpad has the same lagging issue as with ot=
hers
> > > > when run at 400 kHz as the ACPI tables describe. This particular sy=
stem
> > > > does not use standard ACPI ID but it seems to use "Windows Device I=
D"
> > > > VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk lis=
t as
> > > > well but since this is not a standard ACPI ID match it also via DMI
> > > > strings just to be on the safe side.
>=20
> ...
>=20
> > > > Reported-by: penhouse24@proton.me
> > > > Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@bla=
ck.igk.intel.com/
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >
> > > Isn't this https://bugzilla.kernel.org/show_bug.cgi?id=3D214597 as we=
ll?
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20
> 
