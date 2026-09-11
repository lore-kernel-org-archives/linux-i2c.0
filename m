Received: from carlos5.mail.rambler.ru (carlos5.mail.rambler.ru [81.19.78.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B75A514B
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.78.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159169; cv=none; b=HCpDLiEl2Snz9zzWYIRAesOAzhTixE7zlqDIIbP4jy6gBtD1FF5fF8Sh/qIkwbp+9G1HXEUaCpqm3HdVjYT+SSQK4AosbMu5/CxB+7162loOHeEaAm4OK2qJOqbkJPSnnMQH88YvvvUs5L7E9zwI/Ag+5gKQX/Z+6oUnfacOFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159169; c=relaxed/simple;
	bh=/+Pu6+cq4TX/pq90LjqDOQg3GtclZwBGyhGxruRoP8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUpqDFrJw9000Q2ovVlIwvglWOVbgCL9s6/aCX3RfN9+W1+nJJ72iaIS3WApQYoOtZMC8SDkUHJyl/Bj+Q2XtefPYhGmXqI1KBFvUQLLV+S/elU9q8AIgnqOEN50KgeGa4dLLvDeqhu8EClBMpEkb7Enbdd9c0AUQaUHYTO7g5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru; spf=pass smtp.mailfrom=ro.ru; arc=none smtp.client-ip=81.19.78.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ro.ru
Received: from localhost (localhost [127.0.0.1])
	(Authenticated sender: alma0@ro.ru)
	by carlos5.mail.rambler.ru (Postfix) with ESMTPA id E34E96441A02;
	Fri, 11 Sep 2026 23:33:08 +0300 (MSK)
Message-ID: <8d8740a4-6b9f-483b-9ea4-145293e63c25@ro.ru>
Date: Fri, 11 Sep 2026 22:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_ee1004=3A_DDR4_SPD_cannot_be_read=2C_decode-dimms_f?=
 =?UTF-8?B?YWlscywg4oCcRmFpbGVkIHRvIHNlbGVjdCBwYWdlIDAgKC02KeKAnQ==?=
To: Jean Delvare <jdelvare@suse.de>
Cc: 1110749@bugs.debian.org, linux-i2c@vger.kernel.org
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
 <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
 <ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
 <812847a5-5630-4d26-8012-c816e6d1db32@ro.ru>
 <20260911135604.6c2451e7@endymion>
From: Al Ma <AlMa0@ro.ru>
Content-Language: en-US
In-Reply-To: <20260911135604.6c2451e7@endymion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Awesome!

Below, I'll comment on whatever I can meaningfully comment.

> * Short term, you want to blacklist the ee1004 driver on your system.
>    It is not a good idea to load a driver which binds to the wrong
>    device.

Here we go, following https://wiki.debian.org/KernelModuleBlacklisting:

$ echo "blacklist ee1004" | sudo tee /etc/modprobe.d/ee1004.conf
blacklist ee1004
$ sudo depmod -ae
depmod: WARNING: -e needs -E or -F
$ sudo update-initramfs -u
update-initramfs: Generating /boot/initrd.img-6.12.107+deb13-amd64

Can the above warning be ignored?

> * Still mid term, we probably want to blacklist SPD probing explicitly
>    for your motherboard (we'll need to know the contents of
>    /sys/devices/virtual/dmi/id/board_vendor and
>    /sys/devices/virtual/dmi/id/board_name on your system). Maybe this
>    can be implemented as an empty entry in mux_dmi_table (as in, we know
>    the board requires multiplexing, but we don't know yet to implement
>    it on that board).

Here we go:

$ cat /sys/devices/virtual/dmi/id/board_vendor
ASUSTeK COMPUTER INC.
$ cat /sys/devices/virtual/dmi/id/board_name
WS C422 PRO_SE

> * Long term, we need the hardware vendor to provide technical
>    information about the board so that we can implement SMBus
>    multiplexing support in the i2c-i801 driver (if that's really how
>    things are implemented on your board - that's only a guess from me at
>    this point). Asus provided information about their Z8 series long ago
>    and I was able to add support for it back then. It would be wonderful
>    if they could provide similar information about the WS C422 PRO/SE so
>    that a kernel developer can add support.
> 

The user manuals for the board lie at https://www.asus.com/de/motherboards-components/motherboards/workstation/ws-c422-pro-se/helpdesk_manual?model2Name=WS-C422-PRO-SE .

As for anything deeper, it would be better if you, as a developer, contacted them directly. (In fact, the last time I actually succeeded in issuing a ticket was a long time ago, before the warranty ran out.) An ASUS support contact form lies at https://www.asus.com/support/product/contactus/services/questionform .
