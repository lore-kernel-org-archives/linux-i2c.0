Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5122342509;
	Mon, 31 Aug 2026 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174245; cv=none; b=uX5k/x7nqiDIe8H69DszflUPmGGzfCxvTUMtOGTG+iAJhNFDhHly8avk+y4IL0yQTiU7IK4u5O9Y6j2nEvJaI++/MM3jgyXVX0C999BCIOargboMuyj842TluvGX5doUc2K8sFWEVv/CNI81I+DdbrerUnv3i18SOs75GsAD2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174245; c=relaxed/simple;
	bh=ugs0J+3kgd6CXcA7wEZEMH0dHpk60e5vs/8FIKYT2Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2G4RG5G5pHHjABnlMUNzW4ZKlR567gbcLZH9A1tgNOwincKO0vl2BlfIIV+vbjVEIFpVNecxudYH7BT3lUg5WXT2o1He4zZvqI7asw3buMbjPFK01p8Lm9PvajMNhSbRVXrlfKSyCdB7YYmUh89WUe5c4pyKD1ryeegG2cIQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBqubqr7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFk3Plyj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBqubqr7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFk3Plyj"
Date: Mon, 31 Aug 2026 13:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788174242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKdVojaTob1BL9EVMMF0SMBSkZzkm5jYpkSLRLAc5sg=;
	b=SBqubqr7y5Uda5jYuOFtiqvmY4a1zo2r6adT1+qoKFwIrVrDCSxkdAOcg8fCZT2mXJk3NF
	Fp3yc/QfaehpfKk3NdObSdlWHq1RLZ0uiCyySQCilXGSZKxJ2vraOTd1lxEo1J45wv83d5
	gXdLV7u073se6oEekuP1jOVhBeB2CrPm6L7kMcaXKTAH5Qw5krpLpcSBThAH6w/edSgMZy
	34tcD9XC3gxXTmjH0yvmTFZKQR34LQh5eh+lOejsKDukRSlRhJZUs0+DRzq0M8OECcgBR3
	WpP2g4fbSCnH4b11wXcqjNkgwWC1UQGG8O4Tm4AMeSvpyujt247YMGdWu+q3sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788174242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKdVojaTob1BL9EVMMF0SMBSkZzkm5jYpkSLRLAc5sg=;
	b=TFk3PlyjQIc6v3mzGtbcsooVyNSD+z8zrGdQd7Z9w72xOh39O/H3fVs0YKdTFthj/C/E6i
	iYw5G55+4QxAMyAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baineng Shou <shoubaineng@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] i2c: designware: add atomic transfer support for
 IRQ-off contexts
Message-ID: <20260831110401.AafH5Gx-@linutronix.de>
References: <20260807113333.1635449-1-shoubaineng@gmail.com>
 <aneVvWDgfYr5bEun@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aneVvWDgfYr5bEun@ashevche-desk.local>

On 2026-08-08 23:46:53 [+0300], Andy Shevchenko wrote:
> > +	/*
> > +	 * Fall back to the atomic path when IRQs are disabled, e.g. during
> > +	 * noirq system resume where an I2C client (GPIO expander, PMIC)
> > +	 * must be accessed before IRQs are re-enabled.  The i2c core's
> > +	 * i2c_in_atomic_xfer_mode() gate does not cover resume_noirq
> > +	 * (system_state is already SYSTEM_RUNNING there), so the driver has
> > +	 * to route the transfer itself.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled=
())
>=20
> I don't like this. Do we have something better for this?
> Perhaps @bigeasy knows?

This looks hackish indeed. Couldn't this take an argument from the
caller to learn if it is called from the atomic path or the regular?
And could this be tested on PREEMPT_RT to figure out if it works as
intended? I do remember that some driver creates a warning on PREEMPT_RT
due to its atomic call path which is tested from probe. I don't remember
anyone tested it on RT other than just shutting down the warning,
claiming it is okay=E2=80=A6

> > +		return i2c_dw_xfer_atomic(adap, msgs, num);
>=20

Sebastian
