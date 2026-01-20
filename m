Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3345BD6B
	for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920310; cv=none; b=iiQ6qgnEevVc2uzjeMYGWS7UH1a3r5h1kJeEfkfrj8IPR5KUxLwHEyPNJ67LSkQXu7slXq8nsMQNKtwHYjOpIHMnbIhD4p9hAD6i4ehvLap3gvSBQXbwvDZtqPNujNgvpQ5rYsgauu0kEHpiC6fOgiRVtHQ4m4yK01j2FYOQJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920310; c=relaxed/simple;
	bh=yNmNO6pVoIr/VJ06ROIEyjHNUAIDP+FljvOsQmCzjtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBRsA7ll2Sgt3uaqKrNryCMSc6mWr/ocqwlHS/Fm/9ULD408WpYKQJAPktNzCx5Yt31W+CTzzX59uwcEH1sX9tJjOyhefxNgUFQpVb7keJdAXR/Y3oXek1xW3ntb5sFYJU3EJOCjD/iBgQk7USwNyyTcbwfIT5J/hxPIdHNH/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMNomoCI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=665uszSy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMNomoCI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=665uszSy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMNomoCI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="665uszSy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMNomoCI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="665uszSy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06C09337F3;
	Tue, 20 Jan 2026 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768920307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0ehcWx+HW6FgdldOS2AWXmWdto6+IE5MdqGA0kWZM=;
	b=TMNomoCIWOEdz3ZfIJLXNrXdK4qAOQMe9qO75bGO0o1tEd7CgDulH91kIMmTCtGY1Xg1tY
	xfbAsvyKOvGM8LBFtI5itHfG9qz7N6ejY3zL+b9xY9ax4OgYkeHB0bsEakcUt5ax122t3h
	AaqPSHwBnzalPZl0JbxvTUQXPTfvdHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768920307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0ehcWx+HW6FgdldOS2AWXmWdto6+IE5MdqGA0kWZM=;
	b=665uszSyO25mxMIe8kgPDT39TaYxCOBD/VXI3siLVezSiKLdg4WDDmqgudAjI1vErgy7MI
	KJT1lsgnYjolkiDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TMNomoCI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=665uszSy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768920307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0ehcWx+HW6FgdldOS2AWXmWdto6+IE5MdqGA0kWZM=;
	b=TMNomoCIWOEdz3ZfIJLXNrXdK4qAOQMe9qO75bGO0o1tEd7CgDulH91kIMmTCtGY1Xg1tY
	xfbAsvyKOvGM8LBFtI5itHfG9qz7N6ejY3zL+b9xY9ax4OgYkeHB0bsEakcUt5ax122t3h
	AaqPSHwBnzalPZl0JbxvTUQXPTfvdHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768920307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0ehcWx+HW6FgdldOS2AWXmWdto6+IE5MdqGA0kWZM=;
	b=665uszSyO25mxMIe8kgPDT39TaYxCOBD/VXI3siLVezSiKLdg4WDDmqgudAjI1vErgy7MI
	KJT1lsgnYjolkiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 443A63EA63;
	Tue, 20 Jan 2026 14:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gv2YDvKUb2k2cAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 20 Jan 2026 14:45:06 +0000
Date: Tue, 20 Jan 2026 15:45:05 +0100
From: Jean Delvare <jdelvare@suse.de>
To: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH i2c-tools v2 2/2] i2ctransfer: Add optional message
 modifier flags
Message-ID: <20260120154505.7e860faa@endymion>
In-Reply-To: <20251223-msg-flags-v2-2-8d934a4366e2@bootlin.com>
References: <20251223-msg-flags-v2-0-8d934a4366e2@bootlin.com>
	<20251223-msg-flags-v2-2-8d934a4366e2@bootlin.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 06C09337F3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Tue, 23 Dec 2025 14:22:43 +0100, Beno=C3=AEt Monin wrote:
> @@ -202,12 +209,21 @@ int main(int argc, char *argv[])
>  		case PARSE_GET_DESC:
>  			flags =3D 0;
> =20
> -			switch (*arg_ptr++) {
> -			case 'r': flags |=3D I2C_M_RD; break;
> -			case 'w': break;
> -			default:
> -				fprintf(stderr, "Error: Invalid direction\n");
> -				goto err_out_with_arg;
> +			for (int done =3D 0; !done; ) {

For compatibility with older C compilers, please declare "done" at the
beginning of the while loop.

> +				switch (*arg_ptr++) {
> +				/* optional flags */
> +				case 'i': flags |=3D I2C_M_IGNORE_NAK; break;
> +				case 'n': flags |=3D I2C_M_NO_RD_ACK; break;
> +				case 'p': flags |=3D I2C_M_STOP; break;
> +				case 's': flags |=3D I2C_M_NOSTART; break;
> +				case 't': flags |=3D I2C_M_REV_DIR_ADDR; break;
> +				/* mandatory flags */

I would write "mandatory direction flag" (singular because only one can
and must be present).

> +				case 'r': flags |=3D I2C_M_RD; done =3D 1; break;
> +				case 'w': done =3D 1; break;
> +				default:
> +					fprintf(stderr, "Error: Invalid flag\n");
> +					goto err_out_with_arg;
> +				}
>  			}
> =20
>  			if (*arg_ptr =3D=3D '?') {
>=20


--=20
Jean Delvare
SUSE L3 Support
