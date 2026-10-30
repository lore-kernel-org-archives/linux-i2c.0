Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348433;
	b=YutuZe94es/MhcXaSlOyHlo5hFohsylbQbBZVXhukKtuqregpFlYQ23ds0R6yTecAF4p
	 yN6NIvzPU+FoUaz4sPRNhSYnJUFdihvmqQe8g2t7u36Bu3pWx75UAfANu+PZUFJJ+QbR6
	 tNjwUcBkDQPorMjIXmnVUi5sK8atm++kH5p8uI7xAwzgksbVdBhOTXo7V/3vQCIM88zJ6
	 hz66zoh1DioLAoTIjOcnRfRExhc7+xhiEgY2eXCU1yjqUpzuhn7pQdGO7kFbCSuEvvY3B
	 0g7itsTfeqqgQAiYmeRxV+2W8H572wUtG6iu5+veyEaWp8OuVjuoO9GexH7gNAAre2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348433;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=eMw0Tsc5hY6DqmDs0szKnY0CQ5h9hvbZXBJZty/2/ZY=;
	b=qNG/lWxT0kRsja1caEnIlj+SYwEijDXQxXNjDI+V8nL8Pvn0iAoziryAYpAnxJkP02DO
	 nLlunrRS4O2UgnzWuPWfya/5az7FRgV/iWGrC5kFLRHBrDpgBCGc+c0w0aEIT0g5+o2bX
	 jfFlFxt8P2zcO5lu0SMRv6IYodI5xl3IfjFVrXIaQqPHVakdfbZYekJ1EeGFUlr6bZD4h
	 TSe69T1dhAvH9ABwaooLPIaW0V354/mmNw/GjB/Q6xTrSWusqHu6ffREbVusOF57KjgG8
	 6l9JKhzTzv/r7U7XEjbxGhhG+xAnY2t0fx8X5vlxoISZZ3ce0wiW0ZWC3cQmn+ogNqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=aTFFpxxh;
	arc=none smtp.remote-ip=185.70.43.16
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FF606A332
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 08:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744FF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=aTFFpxxh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793348430; x=1793607630;
	bh=eMw0Tsc5hY6DqmDs0szKnY0CQ5h9hvbZXBJZty/2/ZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aTFFpxxhvkz0apQitjCI++GPp1sNBCa5jWnWyXYFtz1GKCM+9ohYEg83HdgIiZiff
	 0KvYohZZJ9NHir8hk7O1KmwAnaLp42qpwZ10UltJy9alQ3bdCBl3+ERqdUmp0dAIZk
	 MXgrUAgXOIIBmtcYsP4k+OjmPARdPdipTAXBtiebXQ2v+570qUTCUMhSZTUz7UlG06
	 pLZ4qyavffn3G22B3YniS687Nc60WSfa6Mzy4a2fwEACWyaCllKftcsC5q1qAEcubD
	 UFVvaDw+7uNwzf3qnnS+QhB79cv3773dTfsOm83etzYEyQaEnxRxFK8EJ0IalDVIxv
	 EQDh7PRa+bNyQ==
Date: Fri, 30 Oct 2026 08:20:25 +0000
To: linux-i2c@vger.kernel.org
From: Yazoudi <Yazoudi@proton.me>
Cc: linux-kernel@vger.kernel.org
Subject: [Linux I2C/SMBus] AMD FCH SMBus controller fails to bind on Gigabyte B850M FORCE WIFI6E
Message-ID: <70db7519-da14-4b59-a196-27f5b67c84bd@proton.me>
In-Reply-To: <defea8da-35df-478e-8c07-226db605bb1d@proton.me>
References: <defea8da-35df-478e-8c07-226db605bb1d@proton.me>
Feedback-ID: 197040310:user:proton
X-Pm-Message-ID: f6cb6cce089e0a0c6e4fed18b1de0a903a89c4c0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_tas4pBrJGPaOHPqnjwdzTAuh5bgQkqaAUyBar8YW1vc"

--b1=_tas4pBrJGPaOHPqnjwdzTAuh5bgQkqaAUyBar8YW1vc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello,

I am investigating an SMBus controller that does not bind to the Linux=20
i2c_piix4 driver on my Gigabyte B850M FORCE WIFI6E (revision 1.0)=20
motherboard.

The PCI device is detected, and i2c_piix4 is listed as a candidate=20
module, but no driver is bound to the device. The kernel also logs an=20
ACPI resource conflict involving the SMBus I/O range and the GSA1.SMBI=20
operation region.

System details:

  *

    Motherboard: Gigabyte B850M FORCE WIFI6E, revision 1.0

  *

    BIOS: F8a

  *

    Distribution: Arch Linux with zen kernel

  *

    Kernel: 7.2.11-zen1-1-zen

  *

    SMBus PCI device: 00:14.0, AMD FCH SMBus Controller [1022:790b],
    revision 71

  *

    PCI subsystem: Gigabyte [1458:5001]

Relevant observations:

 1.

    |lspci -nnk -s 00:14.0|lists |i2c_piix4|under Kernel modules, but
    does not show a Kernel driver in use.

 2.

    |/sys/bus/pci/devices/0000:00:14.0/driver|does not resolve to a driver.

 3.

    The kernel logs:
    |ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08
    conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F
    (\GSA1.SMBI)|
    followed by:
    |ACPI: OSL: Resource conflict; ACPI support missing from driver?|

 4.

    |/proc/ioports|lists |0b00-0b0f : PNP0C02:03|.

 5.

    Reloading i2c_piix4 does not bind the driver, and no SMBus adapter
    appears among the available I=C2=B2C adapters.

I originally investigated this because OpenRGB cannot detect my KLEVV=20
CRAS V RGB DDR5 modules. The |spd5118|driver loads, but no SPD devices=20
are instantiated. I understand that SPD access and RGB control are=20
separate issues; my immediate concern is the SMBus controller not binding.

I found a related patch discussion concerning an ACPI resource conflict=20
on the Gigabyte X870 EAGLE WIFI7:
https://lkml.rescloud.iu.edu/2608.1/09152.html=20
<https://lkml.rescloud.iu.edu/2608.1/09152.html>

That is a different motherboard, so I do not know whether the same=20
underlying issue applies here.

Could you advise whether this looks like an ACPI resource reservation=20
preventing i2c_piix4 from binding, and what additional diagnostics would=20
help establish the cause? I have not forced the driver to bind or=20
disabled the kernel's ACPI resource protections.

I can provide the full kernel log, PCI configuration, and other=20
diagnostic output if needed.

Thank you.


--b1=_tas4pBrJGPaOHPqnjwdzTAuh5bgQkqaAUyBar8YW1vc
Content-Type: text/plain; charset=UTF-8; name=diagnostics.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=diagnostics.txt

PT09IEtlcm5lbCA9PT0KTGludXggWWF6b3VkaVBjIDcuMi4xMS16ZW4xLTEtemVuICMxIFpFTiBT
TVAgUFJFRU1QVF9EWU5BTUlDIEZyaSwgMTYgT2N0IDIwMjYgMDA6Mjg6NDIgKzAwMDAgeDg2XzY0
IEdOVS9MaW51eApMaW51eCB2ZXJzaW9uIDcuMi4xMS16ZW4xLTEtemVuIChsaW51eC16ZW5AYXJj
aGxpbnV4KSAoZ2NjIChHQ0MpIDE2LjIuMSAyMDI2MDgxMCwgR05VIGxkIChHTlUgQmludXRpbHMp
IDIuNDcpICMxIFpFTiBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSwgMTYgT2N0IDIwMjYgMDA6Mjg6
NDIgKzAwMDAKCj09PSBEaXN0cmlidXRpb24gPT09Ck5BTUU9IkFyY2ggTGludXgiClBSRVRUWV9O
QU1FPSJBcmNoIExpbnV4IgpJRD1hcmNoCkJVSUxEX0lEPXJvbGxpbmcKQU5TSV9DT0xPUj0iMzg7
MjsyMzsxNDc7MjA5IgpIT01FX1VSTD0iaHR0cHM6Ly9hcmNobGludXgub3JnLyIKRE9DVU1FTlRB
VElPTl9VUkw9Imh0dHBzOi8vd2lraS5hcmNobGludXgub3JnLyIKU1VQUE9SVF9VUkw9Imh0dHBz
Oi8vYmJzLmFyY2hsaW51eC5vcmcvIgpCVUdfUkVQT1JUX1VSTD0iaHR0cHM6Ly9naXRsYWIuYXJj
aGxpbnV4Lm9yZy9ncm91cHMvYXJjaGxpbnV4Ly0vaXNzdWVzIgpQUklWQUNZX1BPTElDWV9VUkw9
Imh0dHBzOi8vdGVybXMuYXJjaGxpbnV4Lm9yZy9kb2NzL3ByaXZhY3ktcG9saWN5LyIKTE9HTz1h
cmNobGludXgtbG9nbwoKPT09IE1vdGhlcmJvYXJkIGFuZCBCSU9TID09PQpCODUwTSBGT1JDRSBX
SUZJNkUKeC54CkY4YQowMy8xMS8yMDI2Cgo9PT0gU01CdXMgUENJIGNvbnRyb2xsZXIgPT09CjAw
OjE0LjAgU01CdXMgWzBjMDVdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIEZD
SCBTTUJ1cyBDb250cm9sbGVyIFsxMDIyOjc5MGJdIChyZXYgNzEpCglTdWJzeXN0ZW06IEdpZ2Fi
eXRlIFRlY2hub2xvZ3kgQ28uLCBMdGQgRGV2aWNlIFsxNDU4OjUwMDFdCglLZXJuZWwgbW9kdWxl
czogaTJjX3BpaXg0LCBzcDUxMDBfdGNvCjAwOjE0LjAgU01CdXM6IEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4gW0FNRF0gRkNIIFNNQnVzIENvbnRyb2xsZXIgKHJldiA3MSkKCVN1YnN5c3Rl
bTogR2lnYWJ5dGUgVGVjaG5vbG9neSBDby4sIEx0ZCBEZXZpY2UgNTAwMQoJQ29udHJvbDogSS9P
KyBNZW0rIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBT
dGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwLSA2Nk1IeisgVURG
LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9y
dC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJSU9NTVUgZ3JvdXA6IDEwCglLZXJuZWwgbW9kdWxlczog
aTJjX3BpaXg0LCBzcDUxMDBfdGNvCgoKPT09IEkvTyByZXNvdXJjZSByZXNlcnZhdGlvbiA9PT0K
ICAwMDAwLTAwMDAgOiBQTlAwQjAwOjAwCgo9PT0gUmVsZXZhbnQga2VybmVsIG1lc3NhZ2VzID09
PQpPY3QgMzAgMTA6NTE6NTkgWWF6b3VkaVBjIGtlcm5lbDogQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDAwYjAwMDAwMC0weDAwMDAwMDAwMGIwMjBmZmZdICBkZXZpY2UgcmVzZXJ2ZWQKT2N0IDMw
IDEwOjUxOjU5IFlhem91ZGlQYyBrZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBu
b3NhdmUgbWVtb3J5OiBbbWVtIDB4MGIwMDAwMDAtMHgwYjAyMGZmZl0KT2N0IDMwIDEwOjUxOjU5
IFlhem91ZGlQYyBrZXJuZWw6IGU4MjA6IHJlZ2lzdGVyIFJBTSBidWZmZXIgcmVzb3VyY2UgW21l
bSAweDBiMDAwMDAwLTB4MGJmZmZmZmZdCk9jdCAzMCAxMDo1MTo1OSBZYXpvdWRpUGMga2VybmVs
OiBhY3BpIFBOUDBDMDI6MDM6IFJlc2VydmVkIFtpbyAgMHgwYjAwLTB4MGIwZl0KT2N0IDMwIDEw
OjUxOjU5IFlhem91ZGlQYyBrZXJuZWw6IHJ0Y19jbW9zIFBOUDBCMDA6MDA6IFJUQyBjYW4gd2Fr
ZSBmcm9tIFM0Ck9jdCAzMCAxMDo1MTo1OSBZYXpvdWRpUGMga2VybmVsOiBydGNfY21vcyBQTlAw
QjAwOjAwOiByZWdpc3RlcmVkIGFzIHJ0YzAKT2N0IDMwIDEwOjUxOjU5IFlhem91ZGlQYyBrZXJu
ZWw6IHJ0Y19jbW9zIFBOUDBCMDA6MDA6IHNldHRpbmcgc3lzdGVtIGNsb2NrIHRvIDIwMjYtMTAt
MzBUMDY6NTE6NTEgVVRDICgxNzkzMzQzMTExKQpPY3QgMzAgMTA6NTE6NTkgWWF6b3VkaVBjIGtl
cm5lbDogcnRjX2Ntb3MgUE5QMEIwMDowMDogYWxhcm1zIHVwIHRvIG9uZSBtb250aCwgeTNrLCAx
MTQgYnl0ZXMgbnZyYW0KT2N0IDMwIDEwOjUxOjU5IFlhem91ZGlQYyBrZXJuZWw6IEFDUEkgV2Fy
bmluZzogU3lzdGVtSU8gcmFuZ2UgMHgwMDAwMDAwMDAwMDAwQjAwLTB4MDAwMDAwMDAwMDAwMEIw
OCBjb25mbGljdHMgd2l0aCBPcFJlZ2lvbiAweDAwMDAwMDAwMDAwMDBCMDAtMHgwMDAwMDAwMDAw
MDAwQjBGIChcR1NBMS5TTUJJKSAoMjAyNjA0MDgvdXRhZGRyZXNzLTIwNCkKT2N0IDMwIDEwOjUx
OjU5IFlhem91ZGlQYyBrZXJuZWw6IEFDUEk6IE9TTDogUmVzb3VyY2UgY29uZmxpY3Q7IEFDUEkg
c3VwcG9ydCBtaXNzaW5nIGZyb20gZHJpdmVyPwpPY3QgMzAgMTE6MjQ6MjUgWWF6b3VkaVBjIGtl
cm5lbDogQUNQSSBXYXJuaW5nOiBTeXN0ZW1JTyByYW5nZSAweDAwMDAwMDAwMDAwMDBCMDAtMHgw
MDAwMDAwMDAwMDAwQjA4IGNvbmZsaWN0cyB3aXRoIE9wUmVnaW9uIDB4MDAwMDAwMDAwMDAwMEIw
MC0weDAwMDAwMDAwMDAwMDBCMEYgKFxHU0ExLlNNQkkpICgyMDI2MDQwOC91dGFkZHJlc3MtMjA0
KQpPY3QgMzAgMTE6MjQ6MjUgWWF6b3VkaVBjIGtlcm5lbDogQUNQSTogT1NMOiBSZXNvdXJjZSBj
b25mbGljdDsgQUNQSSBzdXBwb3J0IG1pc3NpbmcgZnJvbSBkcml2ZXI/Cg==

--b1=_tas4pBrJGPaOHPqnjwdzTAuh5bgQkqaAUyBar8YW1vc--

