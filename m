From: Sebastian Frias <sf84@laposte.net>
Subject: Re: True Parallel Port Interface for Bit-banging?
Date: Tue, 25 Oct 2016 18:12:54 +0200
Message-ID: <580F8486.70203@laposte.net>
References: <580F4042.5070201@laposte.net>
 <1477401755.4275.18.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpoutz28.laposte.net ([194.117.213.103]:48694 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754240AbcJYQM5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Oct 2016 12:12:57 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout016 (Postfix) with ESMTP id AC24311483F
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 18:12:54 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout016 (Postfix) with ESMTP id 9FF56114CB6
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 18:12:54 +0200 (CEST)
Received: from lpn-prd-vrin004 (lpn-prd-vrin004.prosodie [10.128.63.5])
        by lpn-prd-vrout016 (Postfix) with ESMTP id 9D9FA114C41
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 18:12:54 +0200 (CEST)
Received: from lpn-prd-vrin004 (localhost [127.0.0.1])
        by lpn-prd-vrin004 (Postfix) with ESMTP id 8A63E7101EC
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 18:12:54 +0200 (CEST)
In-Reply-To: <1477401755.4275.18.camel@chaos.suse>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, linux-i2c@vger.kernel.org

On 10/25/2016 03:22 PM, Jean Delvare wrote:
> On mar., 2016-10-25 at 13:21 +0200, Sebastian Frias wrote:
>> Alternatively, does anybody knows if the Parallel Port available thru Laptop
>> docking stations (Dell, HP, Thinkpad, etc.) are True Parallel Ports (ISA
>> compatible)?
> 
> Some laptops such as the ThinkPad T42 had parallel ports, without the
> need of a docking station. I know because my dad still has one. But well
> these are 2004 machines, may be hard to find these days.
> 

Actually, according to this:

https://www-user.tu-chemnitz.de/~heha/basteln/PC/USB2LPT/index.en.htm

PCMCIA cards could work, is anybody able to confirm?
