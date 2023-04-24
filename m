Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC4C7618E
	for <linux-i2c@archiver.kernel.org>; Mon, 24 Apr 2023 21:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDXVvi (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDXVvh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Apr 2023 17:51:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC405128
        for <linux-i2c@vger.kernel.org>; Mon, 24 Apr 2023 14:51:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 251ED5C0162
        for <linux-i2c@vger.kernel.org>; Mon, 24 Apr 2023 17:51:36 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 24 Apr 2023 17:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682373096; x=1682459496; bh=pV
        pTJZAAIHnB7vLJt84AxGyQYkp9cN6ENIQY4vjI060=; b=a+bFYOqzu0OkCbnW+J
        LbtHfk6PYID4BFK9TnNrd3n7OhLSWF2AN1iyuitBEwz4trblYBaD7LI+zbwYrRfZ
        6wNXnM4nkFNtNF3OvCl0WUADWXLVc+wGUOBiGAN5BXPBDutSylxwVjpyVsTh2n9I
        OGwlB51UBZQHHJ0z7+M8JFvZ10d6grIvUQO0HGdtc4cEa2dXH5a0tzMXRl4R7Gg3
        3lrRn12hYQC/UOu4qOLvSQzs9KgH9Nl8KeG4sOaLSeACiqYzV2zLuQsy7/w94SHa
        57NNaiT5tsYtkt+n4UKj4/dcZ2BXKYSGH0cbnlZkVJ0ntbhdRTTJ6Tb1/WIv2JDX
        Dm9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682373096; x=1682459496; bh=pVpTJZAAIHnB7vLJt84AxGyQYkp9cN6ENIQ
        Y4vjI060=; b=e5YmOF8SQO9fk+YU8L437DZ7tTwnEBSomBYzB+GE77MslYHPNHd
        wBZ1hoNxuqPgioet/b3XcUkO/S4JgGd5kH7m3Ua3W0O6ClANbeAz6KEp242n0a18
        Zs33/x0a++nKqboGi9opzT2y/xJuD4zrftdGplB8ov9ut0G8ne5bPz9e75a7bk8k
        rQW04cx1yccws7THSJxOxLGC90pwYjCrJNNABEwgT9G3Gm54EUvUegEgTdLe4ZO8
        0oXq2EmhQvxEmF7ttTMxR72Fqaf1qopAHJgGcZ+Bo9LoATSmS5pmk++1x82t87uE
        k693s5NcTCbJIGLbtMKqIDSkXjoUePwpLgw==
X-ME-Sender: <xms:5_lGZLSixrnXqgcrdr7uReZxfFgdbyXzrbgZqAOj0N2FjNl5wrNQIQ>
    <xme:5_lGZMwap-0bJ9MwRDafWFMa-f5BrBrjnBYpBHrM3MXeesxLh0X69cUz6QiHVqkdX
    AiLNuk5h8pkIzhfCac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhl
    ohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeeffeeltdejheefud
    etjedvleffvdevieegueegffdvffevffevkeeivdfhkeeikeenucffohhmrghinheprhgv
    ughhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:5_lGZA0JquVr__umT6beyk5H037WanRVX3saDwT-tCDsa55Ysc-sRQ>
    <xmx:5_lGZLD0ZnDnT9m_c33KNQRjkDuI67zD_8wmhUIk6GHKP0YfTY_sxw>
    <xmx:5_lGZEgTMMqldTVGm7KvrN63A0JkKc0Fv8wf0Xc5xaxHlYMMtYsDMw>
    <xmx:6PlGZPsv_S1YPQ7ko30r5mRgGDcfEmvB3ikXB3ZgLsvYDT1xOdOTEw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B1FED1700090; Mon, 24 Apr 2023 17:51:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <47ff45c8-20da-4eac-acad-6d51353f95c6@app.fastmail.com>
Date:   Mon, 24 Apr 2023 17:51:15 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     linux-i2c@vger.kernel.org
Subject: intel-lpss 0000:00:15.1: idma64_irq: status=0x0, millions of lines spamming
 journal 
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Downstream bug has dmesg, lspci, acpidump attached
https://bugzilla.redhat.com/show_bug.cgi?id=2188969

The gist is repeating message:

kernel: intel-lpss 0000:00:15.1: idma64_irq: status=0x0

~6800 times in a couple seconds, and in a few hours racked up over 3.3 million.

Bug first appears in 6.3.0-0.rc2.20230317git38e04b3e4240.27.fc39.x86_64+debug
Last good version is 6.3.0-0.rc2.20230315git6015b1aca1a2.25.fc39.x86_64+debug

Bug appears in 6.3.0 release. It does not appear in 6.2 series kernels or older.


--
Chris Murphy
