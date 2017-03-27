From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 1/4] i2c: designware: wait for disable/enable only if
 necessary
Date: Mon, 27 Mar 2017 11:29:25 +0300
Message-ID: <177eece4-0b16-b4b8-5280-a4981a01865a@linux.intel.com>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
 <1471990736-30190-2-git-send-email-lucas.demarchi@intel.com>
 <20170326194459.GB4209@dell-m4800.Home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdC0IbW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Mar 2017 04:31:22 -0400
In-Reply-To: <20170326194459.GB4209@dell-m4800.Home>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrey Utkin <andrey_utkin@fastmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-i2c@vger.kernel.org, Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>

On 03/26/2017 10:44 PM, Andrey Utkin wrote:
> Regression reported: https://bugzilla.kernel.org/show_bug.cgi?id=194969
>
Thanks, I commented the bug.

-- 
Jarkko
