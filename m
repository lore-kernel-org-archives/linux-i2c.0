Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842570;
	b=tw5+wJS+a1oWi0VOxCknjCFpekbbOXqcNM4sN5hcg4/m3tfBRXUG2mCbS/bRTXTQp5JN
	 kZ6o9dYZ0h+nNQ4SR8L3I8dRA/5fUCeJD9ByDPgLDt3GX24hQA3TEsmPQNtGQglS1F20Q
	 RbULErqvsEiaaOU22+J0sIZKhnv0YDHGPEvA5cbWgBKvGsrPXSgfaqzbUOTypNlkAO613
	 XdnyShN+d1Vyt7Gbtydiik3i/XbeM2JUA/4fpQyoi2PhRA1ajd4IhQ8wgpB/6YEh7kSrM
	 D+b7EBprltxJXsVcL/ncYRB9H0Y+6Mqor93z98LoaYOCA90y3UOHjNapgBxSqmpQ9bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842570;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AFA1cIRKffIxRkyTuIqcB5wi2vdgP455jPVg0Gxp6JM=;
	b=Ix/dUlARrCUuuusq2Yb7hKFwa6pkSwVVzemGsEtl0vyC4PUF7AYFPqP4yIAlidWXsM+E
	 tNF/2RU+rTLenO9pONI5PARfdeP5+u/1EIOlteZbhBS1WCXXWDNyRU5Nrv3BXuMw6HQfk
	 R5vpToz4jE5azv1sr+5S3CpAm4YZ5R7lVRW1Ck4572hjBe1OMYZ+/Hf4CQc9pNOfowOxp
	 /3NkmmGQOykS8x/gnZgkL0BB3FcsrKdhYsggZe8H/X57FILACrhBIq9R0xbdnxe3gBnM/
	 gtCYfsnfRvc3eWX96SNXEGpfztptSqSaruOxwH37lYMyZcwuP/MyBKE8tbxySadMwnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jtg5ZyoG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477B606A337
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jtg5ZyoG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C51F000C4
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842570;
	bh=AFA1cIRKffIxRkyTuIqcB5wi2vdgP455jPVg0Gxp6JM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jtg5ZyoGIn328AVg8XzqwK13hFEIiEy+XwbHeyHaRrb1NrcBUVWuyQH1fmKYlf9ZU
	 0YxhYl8yNFloEB5b6HRbL83Iwyx6rWjv9P4NqVweROQvlWJ56zh53MbZjbHcYQdLyN
	 R6kN4kT4csMGldvM2BlZ8XGrRqMpkJT07CmkdDkjXYRebAnlSS5t3vifLjEPnKixAL
	 b+rx9dGAd9+y4EqueNtFndTgShfDDfIQpCryI0GhGD9HLPwnW53yL4OVOaXJDvZH4t
	 zcOmEIU3Eh3obx4jS5Ks50YG/UAE5UKQ/eN4s0TAIkOoLSr/FwWinmCcdVYO+qkhPj
	 ddaIZzbdGK/Zg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso4494105e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 07:22:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE/U1ge/YtsrAO/w3yRIeTSxUaIO+8w6n+2lUJPxk0UaoT4aJ7htM0CjIOYovc4G0gsSWlaXqWvpIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zRTx1crMN2pQxtmr6Y7NaGF/oVG2M0ToTx2pCjxJL2EDB1xRA
	fabJlsMB/VF1kaEKRAkGLrqiH0RcsswZ7D6vGNxIyvDrvKneFyixSWzZX5J03HqTH0nh+x2EpCF
	r6OyBYKwwE2WC9b6bZ+Y4HQXIR6pgUoo=
X-Received: by 2002:a05:6512:1391:b0:5c1:5bd3:c960 with SMTP id
 2adb3069b0e04-5c170b5d89cmr3774298e87.55.1794842568821; Mon, 16 Nov 2026
 07:22:48 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110085125.2535508-1-johan@kernel.org> <20261110085125.2535508-9-johan@kernel.org>
 <CAJZ5v0g+X0etuZSoTrFr2OXgF9o0q+LLLTcQSfvo0A3dib9M4Q@mail.gmail.com> <avsZN96lgaW5IHdh@hovoldconsulting.com>
In-Reply-To: <avsZN96lgaW5IHdh@hovoldconsulting.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 16 Nov 2026 16:22:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jVUzMaLR3dhO=t4HCN5XcUhY_uki7VO=ksr5PXVmY5oA@mail.gmail.com>
X-Gm-Features: AclHuK8DKN9QEQiR10PdUj9dDcBzh4gS6OuZIwlhscI2PjROsX8tIWktLN53RT8
Message-ID: <CAJZ5v0jVUzMaLR3dhO=t4HCN5XcUhY_uki7VO=ksr5PXVmY5oA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] device property: fix fwnode_get_next_child_node() comments
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:54=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Nov 13, 2026 at 06:49:54PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 10, 2026 at 9:52=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
> > >
> > > The parent pointer in fwnode_get_next_child_node() may not point to a
> > > primary firmware node so update the comments to reflect that.
>
> > > @@ -822,12 +822,12 @@ fwnode_get_next_child_node(const struct fwnode_=
handle *fwnode,
> > >         if (IS_ERR_OR_NULL(parent))
> > >                 return NULL;
> > >
> > > -       /* Try to find a child in primary fwnode */
> > > +       /* Try to find a child in parent */
> >
> > I'm not sure if this comment is still useful after the change, so
> > maybe drop it altogether?
>
> Sounds good.
>
> > >         next =3D fwnode_call_ptr_op(parent, get_next_child_node, chil=
d);
> > >         if (next)
> > >                 return next;
> > >
> > > -       /* When no more children in primary, continue with secondary =
*/
> > > +       /* When no more children in parent, continue with any seconda=
ry */
> >
> > What about
> >
> >   /* Direct children exhausted, go to secondary */
>
> That works, but I think I prefer not rewriting the comment completely,
> and having "any" in there to indicate that we may already be scanning a
> secondary node (in which case parent->secondary is -ENODEV).
>
> So something like:
>
>         /* When no more children, continue with any secondary node */

OK
