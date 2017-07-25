From: rpjday@crashcourse.ca
Subject: does "eeprog" utility supersede both "eeprom" and "eepromer"?
Date: Tue, 25 Jul 2017 06:36:43 -0400
Message-ID: <20170725063643.Horde.1qh2VbDII7-FlLw-Qn3uwjy@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:41465 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdGYKgo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Jul 2017 06:36:44 -0400
Received: from [::1] (port=33464 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dZxCm-0005KD-5Y
        for linux-i2c@vger.kernel.org; Tue, 25 Jul 2017 06:36:44 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


   as long as an EEPROM supports the SMBus protocol, is there any reason
to use either of "eeprom" or "eepromer" rather than the more general
"eeprog" utility? from the man page, eeprog would seem to do everything
the other two utilities can do.

rday
