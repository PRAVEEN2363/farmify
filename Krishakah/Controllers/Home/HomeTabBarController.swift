//
//  HomeTabBarController.swift
//  Krishakah
//
//  Created by RichLabs on 27/11/20.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
                }

            }


            // MARK: - UITabBarControllerDelegate
            extension HomeTabBarController: UITabBarControllerDelegate {

                func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
                    return TabBarAnimatedTransitioning()
                }

            }


            // MARK: - UIViewControllerAnimatedTransitioning
            final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

               func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
                    guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

                    destination.alpha = 0.0
                    destination.transform = .init(scaleX: 1.5, y: 1.5)
                    transitionContext.containerView.addSubview(destination)

                    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    destination.transform = .identity
                        destination.alpha = 1
                    }, completion: { transitionContext.completeTransition($0) })
                }

               func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
                    return 0.30
                }

            }
