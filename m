Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840890;
	b=cDlW14dATzGVjq7ASY83zm13wUgwa0kmTj36retaTztc2SzBTOgjcX9SzoxI3EYcERsG
	 WL3TXp+jBTb9Nke665Ilfv/p92iBUllSo8EkuKmuZEszrX+JTGJ0DWQtSCJaj5ceD0zOK
	 2L1CgDDRxTEOC7TbFKeq9ZSacWoQhZ0dWN7pCJt2ArhGQKWkteanTU2hfFLIy0wa9EG3J
	 rd57oy++nOAi1eaCkxFnk70BgHOhS8JDtctaHzwTvAuVjFp4vHetJLLwbE5MOmSvO2ANW
	 O9kEYHPvwrhoNnf1CF1vYIulfeDQa5F9qF2iXXtDBFi18iakB6ubYAUsFEKwEVPv6Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840890;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6E+Va+CKCsxjtmERg3QBVFeSrp0W2o1cypWA/zHVPes=;
	b=07yLyuNe0Pfi017YEe785K/vLsD40/8g0CxTQG3lQK8/LGcLCajV9GGrR9HCKR7yvOPV
	 sSyW5rMPpFMzdYArQRiRAbcQQsDGrgS7bQ1gZ2IOHwVYPrad1mRMZ7mtaaS6C/Re92puN
	 y1bfnce3gusldIvaCi2E+VqXjokDxRqyFNcG7u+NcfTODU5U9RVxHZRTHtmiLGFd8PllZ
	 GqOlwo7VAifq8r7vWdZZ/2mEP/XC46oS2FXOUXPkCBKwFpA2Nvhvjz7cK1sXdSsTH2GZq
	 bDHperE/mQMCAWinknsLp8naxEc/5y1WR3HE8tFQDb4aVqSyfCk/c6DQ/rUZuPczcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj5CP5+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D9606A31C;
	Mon, 16 Nov 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj5CP5+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2252B1F000C4;
	Mon, 16 Nov 2026 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840890;
	bh=6E+Va+CKCsxjtmERg3QBVFeSrp0W2o1cypWA/zHVPes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bj5CP5+ZbuJto60rP+U8NR4Y2EgV2NGanLfyrN6698adQapZzlVxx62lQ2R8j2YYt
	 S7HzGddusfEu54y2KCJ+3BBKREK8sPR7Gz3T6iGcNkOdX+rTCBcxxrOZnCHcRkrjAr
	 WA0jbC5JniHnfAAEgsNQdUq+Hx1LOcOQ0Mrlf842e0ffXIr4QX/+HtNU2h2jiD5l1+
	 IkhPloMWpH59TTWEJJhY8IWS7JsFuIrJ5tb7Myuvbe1oebC77KE2/F6/HNh4mYYWOV
	 hFzwArPXdXzoNtnDt3XMAPWjW1Bu+dJqQKKDyC/Yl0xdDfgLqGWxyJcGIqTzs/Qv2j
	 WZrcdZDGsipVw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xSy6Z-00000003VKN-2Jk6;
	Mon, 16 Nov 2026 15:54:47 +0100
Date: Mon, 16 Nov 2026 15:54:47 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 8/8] device property: fix fwnode_get_next_child_node()
 comments
Message-ID: <avsZN96lgaW5IHdh@hovoldconsulting.com>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-9-johan@kernel.org>
 <CAJZ5v0g+X0etuZSoTrFr2OXgF9o0q+LLLTcQSfvo0A3dib9M4Q@mail.gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g+X0etuZSoTrFr2OXgF9o0q+LLLTcQSfvo0A3dib9M4Q@mail.gmail.com>

On Fri, Nov 13, 2026 at 06:49:54PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 10, 2026 at 9:52 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > The parent pointer in fwnode_get_next_child_node() may not point to a
> > primary firmware node so update the comments to reflect that.

> > @@ -822,12 +822,12 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
> >         if (IS_ERR_OR_NULL(parent))
> >                 return NULL;
> >
> > -       /* Try to find a child in primary fwnode */
> > +       /* Try to find a child in parent */
> 
> I'm not sure if this comment is still useful after the change, so
> maybe drop it altogether?

Sounds good.

> >         next = fwnode_call_ptr_op(parent, get_next_child_node, child);
> >         if (next)
> >                 return next;
> >
> > -       /* When no more children in primary, continue with secondary */
> > +       /* When no more children in parent, continue with any secondary */
> 
> What about
> 
>   /* Direct children exhausted, go to secondary */

That works, but I think I prefer not rewriting the comment completely,
and having "any" in there to indicate that we may already be scanning a
secondary node (in which case parent->secondary is -ENODEV).

So something like:

	/* When no more children, continue with any secondary node */

> 
> >         return fwnode_get_next_child_node(parent->secondary, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
> > --

Johan
