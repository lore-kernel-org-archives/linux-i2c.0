From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] MFD: Add U300 AB3100 core support v2
Date: Mon, 18 May 2009 22:38:08 +0200
Message-ID: <63386a3d0905181338l2ce5bd9er9f6e4470e3656dd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ChangeLog from v1 -> v2:

* use dynamically allocated struct ab3100 holder for
  state encapsulation.

* Create sub-platform_devices for all the devices found
  inside the AB3100. This is done after init, and all
  drivers have to pass the driver_data back in order
  to call back into ab3100-core. I also define a resource
  containing the register range applicable for each
  functionality so that it is actually possible to
  limit register access to the appropriate registers for
  each sub-device sometime further down the road.

* Since all sub-devices are initialized after the AB3100,
  the initialization check could be removed from all
  symbols.

* Converted the callback into a broadcasting notifier,
  simplifying that code quite a bit by catenating the
  event flags into a 24-bit field passed as value to
  the listeners for masking and reacting to the proper
  events.

* Register a secondary dummy I2C client for performing
  test register operations.

* const on AB3100 debugfs file operations struct.

* free_irq() on the IRQ.


Linus Walleij
