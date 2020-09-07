Return-Path: <SRS0=j4Wp=CQ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC4C433E2
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Sep 2020 01:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C50D2151B
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Sep 2020 01:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gIRH+tfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIGBaH (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 6 Sep 2020 21:30:07 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36414 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbgIGBaF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 6 Sep 2020 21:30:05 -0400
X-UUID: ccd8c52124f14886a9bbf999c88e3ed6-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TgnMLc6W6HXqtA9fqTYfDPNEoYo39SkQDD2kUs7sHYg=;
        b=gIRH+tfsdYpZAHUS9Dpz8ofNTjRGePsmL7ydBVzDWeiP5ju0BNLWETDsSBxw5X1WjZaOxipQmSkwBm/VR0Uq7syb1As3VpO+oxfOtZFqhQ61SR+53Vxo8K2r3+1YkhOn6R5ZBGbn0tclLj+RZKzULUKxAQTKMUSangzOtIsssWk=;
X-UUID: ccd8c52124f14886a9bbf999c88e3ed6-20200907
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 674471685; Mon, 07 Sep 2020 09:29:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Sep
 2020 09:29:54 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 09:29:51 +0800
Message-ID: <1599442087.25719.2.camel@mhfsdcap03>
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mt65xx: Update binding example
From:   Qii Wang <qii.wang@mediatek.com>
To:     Boris Lysov <arzamas-16@mail.ee>
CC:     <linux-i2c@vger.kernel.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>
Date:   Mon, 7 Sep 2020 09:28:07 +0800
In-Reply-To: <20200904223345.3daea5ad@hp15>
References: <20200904223345.3daea5ad@hp15>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FD92D2E6DA5294274C41022820C3C6026CA7D0C81EF6E1B85EAA24DD0C25AD0C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTA0IGF0IDIyOjMzICswMzAwLCBCb3JpcyBMeXNvdiB3cm90ZToNCj4g
RXhhbXBsZSB1c2VzIHZhbHVlcyBmb3IgTVQ2NTg5IFNvQywgYnV0IE1UNjU3NyB3YXMgc3BlY2lm
aWVkIGluICJjb21wYXRpYmxlIiBwcm9wZXJ0eS4NCj4gDQoNCldoeSBkbyB5b3UgdGhpbmsgdGhl
IGV4YW1wbGUgaXMgTVQ2NTg5IFNvQywgbm90IE1UNjU3Nz8NCg0KPiBTaWduZWQtb2ZmLWJ5OiBC
b3JpcyBMeXNvdiA8YXJ6YW1hcy0xNkBtYWlsLmVlPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLW10NjV4eC50eHQgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1eHgudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXQ2NXh4LnR4dA0KPiBp
bmRleCA3ZjAxOTRmZGQwY2MuLmFjZjNkNGQyOGI5OCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXQ2NXh4LnR4dA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdDY1eHgudHh0DQo+IEBAIC0z
Niw3ICszNiw3IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICBFeGFtcGxlOg0KPiAgDQo+ICAJ
aTJjMDogaTJjQDExMDBkMDAwIHsNCj4gLQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2NTc3
LWkyYyI7DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjU4OS1pMmMiOw0KPiAgCQkJ
cmVnID0gPDB4MTEwMGQwMDAgMHg3MD4sDQo+ICAJCQkgICAgICA8MHgxMTAwMDMwMCAweDgwPjsN
Cj4gIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA0NCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KDQo=

