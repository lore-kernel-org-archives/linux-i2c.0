From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC 1/4] x86/platform/intel/iosf_mbi: Add a mutex for punit
 access
Date: Fri, 13 Jan 2017 13:12:15 +0200
Message-ID: <d504f816-96f6-a745-e73c-eb0ea1bd8620@linux.intel.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-2-hdegoede@redhat.com>
 <20170102141242.GY31595@intel.com>
 <2ecf7b65-98aa-696b-f399-1f2d15d0ea65@redhat.com>
 <20170113092644.GD31595@intel.com>
 <3e46500b-8e22-6aa1-8142-97bcbd5d5571@linux.intel.com>
 <20170113105127.GH31595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:42337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdAMLMT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Jan 2017 06:12:19 -0500
In-Reply-To: <20170113105127.GH31595@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

On 01/13/2017 12:51 PM, Ville Syrjälä wrote:
> On Fri, Jan 13, 2017 at 12:34:54PM +0200, Jarkko Nikula wrote:
>> On 01/13/2017 11:26 AM, Ville Syrjälä wrote:
>>> It also feels quite hand wavy since the punit could do whatever at
>>> any time AFAIK. Eg. if there's some thermal event or something the
>>> punit might kick into action. So trying to protect this from the OS
>>> side might not be able to avoid these problems entirely. It feels like
>>> there really should be some kind of shared hardware/firmware mutex
>>> with the punit to arbitrate access to the i2c bus.
>>>
>> There is an HW semaphore for I2C access. It is implemented in
>> drivers/i2c/busses/i2c-designware-baytrail.c and another set from Hans
>> is adding support for Cherrytrail into it.
>
> Then why do we need anything else?
>
 From this patch: "The punit on baytrail / cherrytrail systems is not 
only accessed through the iosf_mbi functions, but also by the i915 code."

-- 
Jarkko
