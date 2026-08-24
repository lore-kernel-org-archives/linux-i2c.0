Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B66283FDC;
	Mon, 24 Aug 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571958; cv=none; b=AjKluj7BLJ31mzol09zIuU/rhOyH0DiW3BeInQ2daCB/HrT80YQ05RQHw0+Srg+oIm9eo0sGob/ERsyEMYOv9E5jkTeEIKfkygFurUcQMhW1ZS9Se72ZL3fYqCrcFdEWdYat3Jewhb/QjsRtCYEfWoklKtJxT6Lk/2zxk8lXGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571958; c=relaxed/simple;
	bh=hO2nmu029mDWr9QNpY5He+SO540c5MuHUNxMjjjZWhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXnoCIMU0AsW8lPlKmrSPlTC31SoMLvm3nnJLBrFAjkI0W3i6ik3VJPRCk97zoH1JSNco661fFg++glOazASFqD7EEH54vOHCxcmy1khpjer3aAu48DHRrV0TrvOqBpErnykIYPKwctUOVlIGsDiKkzAGYd8/qSuTTXxSymEkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWGRgE+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWGRgE+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDBD1F00A3E;
	Mon, 24 Aug 2026 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787571957;
	bh=GjTPPs4GSXZXR2AKtDG1TIuA+KACl5nj+KCCn/Cx+CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nWGRgE+ax3u7xI+gwAZOPjhOifFvwiLXEwH4bNsJrcaNRIsFZlOCRj6aeXTA5WiyD
	 AxC7lYjB6yOLX9zHUBcTTc2wRPmG7A5MTktzjlz3jU0pY8OZsBGhM+DrqC4NZThGm8
	 L9LGekdp3jvehUd+uyeAGWRnqwhEefv+nVIjG5QVvxawmC98HH8cSdaRlme7TdzUKw
	 HDAtdGTCF1qPyfyZyr2ofRJiub92CIcAtN6UrzDuxcZFSKQhKJ5N1WelUe5SSv/pjG
	 p3aI85UrDJe5WqPFuki9VSOR2X1NJVt8042hnmp+0pcLIUkaOvjn47FTPSwj+wsezk
	 Cle3QrMbeay4g==
Date: Mon, 24 Aug 2026 13:45:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Igor Korotin <igor.korotin@linux.dev>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [GIT PULL] rust-i2c-next for 7.3
Message-ID: <aowtivMDF-Rp59Kz@zenone.zhora.eu>
References: <178717488339.2840.16053648973983973210@linux.dev>
 <aodUPU8RGR1ZJlQm@zenone.zhora.eu>
 <178739872719.9834.5401695033021882071@linux.dev>
 <aomUXhYE0M37I-hI@zenone.zhora.eu>
 <CAMuHMdXxosPBAAO-kTKRLDH3o8Cqsx8bf+G28qJxQmPuQXwwhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXxosPBAAO-kTKRLDH3o8Cqsx8bf+G28qJxQmPuQXwwhQ@mail.gmail.com>

Hi Geert,

On Mon, Aug 24, 2026 at 09:54:09AM +0200, Geert Uytterhoeven wrote:
> On Mon, 24 Aug 2026 at 01:30, Andi Shyti <andi.shyti@kernel.org> wrote:
> > > No problem, rebased on i2c/i2c. Updated pull below.
> >
> > Thank you!
> >
> > > Thanks
> > > Igor
> > >
> > > The following changes since commit 7a79b02dd1b09c235c3cf6075bccca2160d1b826:
> > >
> > >   i2c: rcar: fix reset handling for Gen5 (2026-08-19 22:07:13 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/ikrtn/linux.git tags/rust-i2c-for-7.3
> > >
> > > for you to fetch changes up to b5fa55ad007059547c9139d4c4872e158ae255f2:
> > >
> > >   i2c: rust: mark I2cAdapter methods as inline (2026-08-22 12:22:27 +0100)
> >
> > merged to i2c/i2c.
> 
> Apparently you merged both branches, now having the same commit twice:
> 
> + 61ddec70c9bcc3d4 i2c: rust: mark I2cAdapter methods as inline
> + b5fa55ad00705954 i2c: rust: mark I2cAdapter methods as inline
> 
> Gr{oetje,eeting}s,

Thanks for checking and letting me know!

It's in i2c/i2c-next (or next/master). I made the mistake of not
cleaning up the first merge before pushing the change. Since this
duplicate merge log will never reach mainline, I don't want to
rewrite the i2c-next branch history now. Everything will be reset
to mainline at 7.3-rc1 anyway.

Andi
