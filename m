Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F717340281
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015197; cv=pass; b=XbJ6RuAA8od848LVwgiuEFH16tYlXKdEearL0mf8t1XHuoqiP0toyVFrloPcO4xxi5wOUxZ0dTEwliJUuv3pDhR2/B9zHG37cgDlxa9bLThOn000kAbBMfeX+Zse/0YpYW3pJ1CLF2Htg17fu2WT1BT2eQuk5sA1i3CajmTyW6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015197; c=relaxed/simple;
	bh=eHEG/xfDI4QVRzLkC333ArRNT1z/YuMXQtFRTicIrLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY85Kgtrxfe6xLxrGnI9AYaZOm2z75J8TguT5hubZ/oe6LGmuDZUXqlj5g+q04C09P0aufoE9TJBGP/UcL0lyee0mq6zKQzQOVRs6jrQBwQQUVNcuaLWBoYWOClMT/0KlMk9bA/ui2aQYXu4Yh2ATqazbw+vIa3ZmyM7iLMTV8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrSnHIJl; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrSnHIJl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7efd2dc350cso20135667b3.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 07:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015194; cv=none;
        d=google.com; s=arc-20240605;
        b=NeUwZZW6jk1QeqldYP2mrqbaHvEN79jMDDw0BV5aLn0tDdRJqrseQHnsYnIu+GI4uV
         EXARVPX9/xWZWBz9rcXO3JxD3Df+xqTbEXOBd9BQhC7xb9uYg683SLLbjh8vWrp1ikNX
         1J8C3j2TLnEGoh9Q8hBimnD6uFpju4z7QA630qQDKC+wMaXS3gjtGtDGD8tobxa8HzPk
         XzgYhSphf44gINhXiRgxZG8yMPVUtd0xFNpK5Y3RTkl81dcivR4AFuW1IfRD/8VoQlem
         s+t8IyzoHjGOlbVmuXP5u5Gpxn2u4cUiYYe0oxluXYMz2n97NEIlJCOSQk5YzcDJjm4C
         JM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHEG/xfDI4QVRzLkC333ArRNT1z/YuMXQtFRTicIrLU=;
        fh=ySMHbjKqusC6n+FBEi8cTSPHN2UcxfK6cxV/4igi7MQ=;
        b=GGNWCREfItgTg60BuygMYrYkyi/ff3+6jbnQZYZvYOBuIebok6fFBUDdGb2JKoUPbm
         50DK/YNPe+i0TG0Lcfy/n+8+5g5i3vCd/mD9PwgE5zNIYf+22Cf3wu+SN8gL9w8Ahy66
         6H94QW66srdm6+SIHnNGkrfXqwLn2DpuSGc472a+0Wm0fXNAF6R/Tdx8ecnec8tEyI3e
         7AUeKl30+CTyABDe2Vt5RNvxJjsCL57kD8aQtI8sf2InOjjq/rkXvjUTiGDw1gPRhKWP
         ZiNkoGkwt4ej2iP8a2aclL1Hu8j9KmaYUt22TUf6j1daKl087167ZFC8/z8CAFGnDYHu
         QBTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015194; x=1781619994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHEG/xfDI4QVRzLkC333ArRNT1z/YuMXQtFRTicIrLU=;
        b=SrSnHIJlGMQV10+U3W0LDx8IqWoUfg246OXQwZvnFcqIvw0S5ymN2UQ+GQrdBv8hgg
         snX6O2cvHp6wDSKbOxxnQcNRl+sHylDo465jXQWm9/mZ1XBUwW8t/7kvgaSnju9fKCgQ
         JkqWs9guvuNrv7UV0AC5WT4+MnxDersnLYbgE9bcpC4kCBrsOmQEvjjfHUP95oD3ZoD7
         NwQzliu6RLeCk7Qw/5OXmsG6wcSfMmZw+nyOCkgVDtofX9+F3vUereVaGPxqkomYWY2G
         bj+R0T1W+xL9iHFj8h3cP/c+GLXfvDEnZOz5GTQttBoRKBtoEl1+5wc8AdQf9QxflZzS
         s7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015194; x=1781619994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHEG/xfDI4QVRzLkC333ArRNT1z/YuMXQtFRTicIrLU=;
        b=iyRPn1rVtTNdFVOF+vnmReEyXt04WqEbbQ/xWArY2+bMtSUdoCiVkmU1kO8gEPEjbi
         SkcYGJs2Y3Iu+GxJYtn02qvV3n6T6I85XM9gj2a6+UQKxVYT7a/Rm54MC7REzwslTPZ/
         WKWdAd2h9+fzx8o/QwB2YtVWiEBpyMcDopicMsxCrV0w6ysWp4yHrMzL/UZ/zVDsg9er
         0wMkWKyH2exYmovyzQGR25X4/0yq1x9fV6ljfRPuMA1QEYTC2iEaSkajI9xi+jhslfZ/
         lQZnKXI3cAir3H6ixe7lbC6nhfSTvbihss3/z7XwsRo9ISgZzYT2EqQgPN5QI1j1Y5Qg
         YU3A==
X-Forwarded-Encrypted: i=1; AFNElJ++CiU+PBTtjtUTICDf5VdxGf2Nk/GUyJ3Is0GwnCOUBgJicgwVr+m7O0jxvcDqvqkHXaVqL6X5Ctk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWaUVDziyeAAwji+Cn1YrZyUdjFgn9gnOw6bt4psdWK0N27oR
	E2QTlxVCgMT2AElXiueGcw3fnn2aIMGzMiY6PUlcxfe9Xh4iSKwX/iFLapdTDnG2WR306cJcJPy
	L0S3ZBelYpKc5U/GuOPL2SjOdjfx3LzY=
X-Gm-Gg: Acq92OFg1Uq+bkUtOXnWEklstxqhLL9FYSm3tDYAG7By50CPk+pgxWLsn0z3Jeh4VEM
	QANa0vqHvqjXILCx0UlRkS8I0sv9r2S/Z1C0PfewE42F3HZzKFmVie0cdgfhR/POVTrme+0DodX
	CNPJ5z+s6xyGpjQjjhbxQcJi7u8LTUIf+5ohQbqdQZSvlvCyVptEdrQn6Ep01AjwdzeP4V3Z9bF
	cjyV22ndgOfUb9cwpKGRDyLpdFzJtC/gjBhcD4eW/kxMaZlaXl3UrkblVkzzC3RHL1vbktBfRwJ
	F8sqHBtp7dW6b7kDFjY=
X-Received: by 2002:a05:690c:4481:b0:7db:ccda:a40d with SMTP id
 00721157ae682-7f2b4cb2116mr28302087b3.5.1781015194341; Tue, 09 Jun 2026
 07:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
In-Reply-To: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Tue, 9 Jun 2026 19:56:21 +0530
X-Gm-Features: AVVi8CennXEvmKXZcOS3a-5UF83FXzEW1vW2_jb7_VGjy_gZpB9TQvK-ef8eNYE
Message-ID: <CAKfKVtGztJkU_HXZTrb2h3hrTJp0SbRo-sDHM4Sj_1SG8ymOyw@mail.gmail.com>
Subject: Re: [PATCH 0/3] i2c: xiic: fix SMBus block read and PEC support
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 5:48=E2=80=AFAM Abdurrahman Hussain via B4 Relay
<devnull+abdurrahman.nexthop.ai@kernel.org> wrote:
>
> This series fixes three independent bugs in the Xilinx AXI IIC driver
> that together make SMBus block reads with PEC return -EBADMSG or -EIO
> on otherwise clean transfers. They only surface when the client has
> I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
> turn.
>
> The problems were uncovered driving an adm1266 PMBus device behind a
> Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.
>
> Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
> The i2c core appends a byte to msg->len when PEC is enabled, so
> overwriting the length to "block size + 1" silently drops the PEC byte
> and i2c_smbus_check_pec() then reads the last payload byte as the PEC.
>
> Patch 2 raises the RX_FULL threshold so the interrupt only fires once
> every remaining byte (payload plus optional PEC) is already buffered in
> the FIFO. The previous threshold of rxmsg_len - 2 caused the
> bytes_rem =3D=3D 1 path in xiic_read_rx() to NACK a byte still on the wir=
e.
>
> Patch 3 stops the BNB handler from forcing tx_msg->len =3D 1 to signal
> completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
> so this also clobbered rx_msg->len; and because tx_pos is already at 2
> in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
> and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
> up to msg->len drives tx_space to zero without touching the length.
>
> All three patches are pure bug fixes; non-PEC behaviour is unchanged.
> Tested on real hardware -- a Xilinx AXI IIC controller talking to an
> adm1266, where 64-byte PEC-checked block reads now complete cleanly.
>
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

LGTM
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
