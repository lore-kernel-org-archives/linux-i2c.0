From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Question related i2c fixed clk rate
Date: Thu, 25 Aug 2016 17:00:31 +0000
Message-ID: <MWHPR12MB121624883C79696F1A248570A0ED0@MWHPR12MB1216.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0086.outbound.protection.outlook.com ([104.47.34.86]:35904
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758282AbcHYXg4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 19:36:56 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "linux-i2c-owner@vger.kernel.org" <linux-i2c-owner@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi,
I am new to this. Appreciate your help for my query.
I am working on updating i2c-designware clock rate for AMD upcoming platfor=
m. Here new 150000000 clk rate will be supported. I want to validate this b=
ut currently in our platform I do not have any i2c lines out. Is there any =
tool or way to check if this is getting setup properly.
Basically I want to change
 .fixed_clk_rate =3D 133000000 to=20
.fixed_clk_rate =3D 150000000 in acpi_apd.c file.

--
Nehal
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the=
 body of a message to majordomo@vger.kernel.org More majordomo info at  htt=
p://vger.kernel.org/majordomo-info.html
